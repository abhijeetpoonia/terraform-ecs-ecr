# terraform.tfvars - Corrected configuration for ap-south-1

# Basic Configuration
aws_region   = "ap-south-1"
environment  = "dev"
project_name = "my-app"

# VPC Configuration
vpc_cidr                 = "10.0.0.0/16"
public_subnet_cidrs      = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs     = ["10.0.3.0/24", "10.0.4.0/24"]
database_subnet_cidrs    = ["10.0.5.0/24", "10.0.6.0/24"]

# ECS Configuration
instance_type      = "t2.medium"
key_name          = "my-key-pair-ap-south-1"
log_retention_days = 7
task_cpu          = 256
task_memory       = 512
desired_count     = 2
min_capacity      = 2
max_capacity      = 2

# ECS Instance Configuration
ecs_root_volume_size           = 30
ecs_root_volume_type           = "gp3"
ecs_enable_detailed_monitoring = false
ecs_allowed_cidr_blocks        = ["0.0.0.0/0"]
ecs_additional_security_group_ids = []

# RDS Configuration
# Engine Configuration
engine                = "mysql"
engine_version        = "8.0.41"
major_engine_version  = "8.0"

# Instance Configuration
db_instance_class     = "db.t3.medium"
reader_instance_class = "db.t3.medium"

# Storage Configuration
allocated_storage     = 20
max_allocated_storage = 100
storage_type          = "gp2"
storage_encrypted     = true

# Network Configuration
mysql_port           = 3306
publicly_accessible  = false
multi_az             = true
allow_public_access  = true  # Set to false for production


# Database Configuration
db_username = "admin"
db_password = "secret123"
db_name     = "myapp"

# Database Parameter Configuration
max_connections   = "1000"
slow_query_log    = "1"
long_query_time   = "2"
general_log       = "1"

# Backup Configuration
backup_retention_period = 7
backup_window          = "03:00-04:00"
maintenance_window     = "sun:04:00-sun:05:00"
copy_tags_to_snapshot  = true
skip_final_snapshot    = true

# Monitoring Configuration
monitoring_interval                     = 60
performance_insights_enabled           = true
performance_insights_retention_period  = 7

# CloudWatch Logs Configuration
enabled_cloudwatch_logs_exports = ["error", "general", "slowquery"]
cloudwatch_log_retention_days   = 7

# Security Configuration
secret_recovery_window_prod     = 30
secret_recovery_window_non_prod = 0
deletion_protection_prod        = true
deletion_protection_non_prod    = false

# Auto Minor Version Upgrade
auto_minor_version_upgrade = true

# Deprecated Variables (kept for compatibility)
reader_instance_count    = 2
backtrack_window        = 0
enable_auto_scaling     = false
auto_scaling_min_capacity = 1
auto_scaling_max_capacity = 5
auto_scaling_target_cpu   = 70
ecs_task_cpu            = 256
ecs_task_memory         = 512
ecs_log_retention_days  = 7
 
