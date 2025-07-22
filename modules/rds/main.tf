# RDS Parameter Group for MySQL 8.0
resource "aws_db_parameter_group" "main" {
  family = "mysql8.0"
  name   = "${var.environment}-mysql-parameter-group"

  parameter {
    name  = "innodb_buffer_pool_size"
    value = "{DBInstanceClassMemory*3/4}"
  }

  parameter {
    name  = "max_connections"
    value = var.max_connections
  }

  parameter {
    name  = "slow_query_log"
    value = var.slow_query_log
  }

  parameter {
    name  = "long_query_time"
    value = var.long_query_time
  }

  parameter {
    name  = "general_log"
    value = var.general_log
  }

  tags = {
    Name        = "${var.environment}-mysql-parameter-group"
    Environment = var.environment
  }
}

# RDS Option Group for MySQL 8.0
resource "aws_db_option_group" "main" {
  name                     = "${var.environment}-mysql-option-group"
  option_group_description = "MySQL 8.0 option group for ${var.environment}"
  engine_name              = "mysql"
  major_engine_version     = var.major_engine_version

  tags = {
    Name        = "${var.environment}-mysql-option-group"
    Environment = var.environment
  }
}

# RDS Security Group - FIXED VERSION
resource "aws_security_group" "rds" {
  name        = "${var.environment}-rds-sg"
  description = "Security group for RDS MySQL"
  vpc_id      = var.vpc_id

  # Instead of depending on ECS security group ID, use VPC CIDR or specific subnet CIDRs
  ingress {
    from_port   = var.mysql_port
    to_port     = var.mysql_port
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]  # Allow from entire VPC
    description = "Allow MySQL from VPC"
  }

  # OR use specific subnet CIDRs if you want more control
  # ingress {
  #   from_port   = var.mysql_port
  #   to_port     = var.mysql_port
  #   protocol    = "tcp"
  #   cidr_blocks = var.private_subnet_cidrs  # Allow from private subnets only
  #   description = "Allow MySQL from private subnets"
  # }

  # Remove this for production - only allow from ECS
  dynamic "ingress" {
    for_each = var.allow_public_access ? [1] : []
    content {
      from_port   = var.mysql_port
      to_port     = var.mysql_port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow MySQL from anywhere"
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-rds-sg"
    Environment = var.environment
  }
}

# Secrets Manager
resource "aws_secretsmanager_secret" "db_password" {
  name                    = "${var.environment}/rds/password"
  description             = "RDS MySQL password for ${var.environment}"
  recovery_window_in_days = var.environment == "prod" ? var.secret_recovery_window_prod : var.secret_recovery_window_non_prod

  tags = {
    Name        = "${var.environment}-rds-password"
    Environment = var.environment
  }
}

# Use custom password from tfvars instead of random generation
resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = var.db_password
}

# IAM Role for Enhanced Monitoring
resource "aws_iam_role" "rds_monitoring" {
  count = var.monitoring_interval > 0 ? 1 : 0
  name  = "${var.environment}-rds-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "monitoring.rds.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  tags = {
    Name        = "${var.environment}-rds-monitoring-role"
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "rds_monitoring" {
  count      = var.monitoring_interval > 0 ? 1 : 0
  role       = aws_iam_role.rds_monitoring[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

# CloudWatch Log Group for MySQL logs
resource "aws_cloudwatch_log_group" "mysql_logs" {
  for_each = toset(var.enabled_cloudwatch_logs_exports)
  
  name              = "/aws/rds/instance/${var.environment}-mysql-main/${each.value}"
  retention_in_days = var.cloudwatch_log_retention_days

  tags = {
    Name        = "${var.environment}-mysql-${each.value}-logs"
    Environment = var.environment
  }
}

# Primary RDS MySQL Instance (Multi-AZ)
resource "aws_db_instance" "main" {
  identifier = "${var.environment}-mysql-main"
  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.db_instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type
  storage_encrypted     = var.storage_encrypted
  kms_key_id           = var.kms_key_id

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  # Network Configuration
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = var.publicly_accessible

  # Multi-AZ Configuration
  multi_az = var.multi_az

  # Parameter and Option Groups
  parameter_group_name = aws_db_parameter_group.main.name
  option_group_name    = aws_db_option_group.main.name

  # Backup Configuration
  backup_retention_period = var.backup_retention_period
  backup_window          = var.backup_window
  maintenance_window     = var.maintenance_window
  copy_tags_to_snapshot  = var.copy_tags_to_snapshot

  # Monitoring Configuration
  monitoring_interval = var.monitoring_interval
  monitoring_role_arn = var.monitoring_interval > 0 ? aws_iam_role.rds_monitoring[0].arn : null

  # Performance Insights
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_enabled ? var.performance_insights_retention_period : null

  # CloudWatch Logs
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  # Snapshot Configuration
  skip_final_snapshot = var.skip_final_snapshot

  # Deletion Protection
  deletion_protection = var.environment == "prod" ? var.deletion_protection_prod : var.deletion_protection_non_prod

  # Auto Minor Version Upgrade
  auto_minor_version_upgrade = var.auto_minor_version_upgrade

  tags = {
    Name        = "${var.environment}-mysql-main"
    Environment = var.environment
    Role        = "primary"
  }
}

# Read Replica 1
resource "aws_db_instance" "replica_1" {
  identifier = "${var.environment}-mysql-replica-1"

  # Replicate from main instance
  replicate_source_db = aws_db_instance.main.identifier

  instance_class = var.reader_instance_class

  # Network Configuration
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = var.publicly_accessible
  storage_encrypted = true

  # Parameter and Option Groups
  parameter_group_name = aws_db_parameter_group.main.name
  option_group_name    = aws_db_option_group.main.name
  skip_final_snapshot  = var.skip_final_snapshot

  # Monitoring Configuration
  monitoring_interval = var.monitoring_interval
  monitoring_role_arn = var.monitoring_interval > 0 ? aws_iam_role.rds_monitoring[0].arn : null

  # Performance Insights
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_enabled ? var.performance_insights_retention_period : null

  # CloudWatch Logs
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  # Auto Minor Version Upgrade
  auto_minor_version_upgrade = var.auto_minor_version_upgrade

  # Ensure main instance is fully available before creating replica
  depends_on = [aws_db_instance.main]

  tags = {
    Name        = "${var.environment}-mysql-replica-1"
    Environment = var.environment
    Role        = "replica"
  }
}

# Read Replica 2
resource "aws_db_instance" "replica_2" {
  identifier = "${var.environment}-mysql-replica-2"

  # Replicate from main instance
  replicate_source_db = aws_db_instance.main.identifier

  instance_class = var.reader_instance_class
  storage_encrypted = true

  # Network Configuration
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = var.publicly_accessible

  # Parameter and Option Groups
  parameter_group_name = aws_db_parameter_group.main.name
  option_group_name    = aws_db_option_group.main.name
  skip_final_snapshot  = var.skip_final_snapshot

  # Monitoring Configuration
  monitoring_interval = var.monitoring_interval
  monitoring_role_arn = var.monitoring_interval > 0 ? aws_iam_role.rds_monitoring[0].arn : null

  # Performance Insights
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_enabled ? var.performance_insights_retention_period : null

  # CloudWatch Logs
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  # Auto Minor Version Upgrade
  auto_minor_version_upgrade = var.auto_minor_version_upgrade

  # Ensure replica_1 is created before creating replica_2 to avoid conflicts
  depends_on = [aws_db_instance.replica_1]

  tags = {
    Name        = "${var.environment}-mysql-replica-2"
    Environment = var.environment
    Role        = "replica"
  }
}