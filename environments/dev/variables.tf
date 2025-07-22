# variables.tf (Root Module)

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "my-app"
}

# VPC Configuration
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "database_subnet_cidrs" {
  description = "CIDR blocks for database subnets"
  type        = list(string)
  default     = ["10.0.5.0/24", "10.0.6.0/24"]
}

# ECS Configuration
variable "instance_type" {
  description = "EC2 instance type for ECS instances"
  type        = string
  default     = "t2.medium"
}

variable "key_name" {
  description = "EC2 Key Pair name"
  type        = string
  # You need to create this key pair in ap-south-1 region
}

variable "task_cpu" {
  description = "CPU units for the task"
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "Memory for the task"
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Desired number of tasks"
  type        = number
  default     = 2
}

variable "min_capacity" {
  description = "Minimum number of instances"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum number of instances"
  type        = number
  default     = 10
}

variable "log_retention_days" {
  description = "CloudWatch log retention in days"
  type        = number
  default     = 7
}

# ECS Instance Configuration
variable "ecs_root_volume_size" {
  description = "Root volume size in GB for ECS instances"
  type        = number
  default     = 30
}

variable "ecs_root_volume_type" {
  description = "Root volume type for ECS instances"
  type        = string
  default     = "gp3"
}

variable "ecs_enable_detailed_monitoring" {
  description = "Enable detailed monitoring for ECS instances"
  type        = bool
  default     = false
}

variable "ecs_enable_public_ip" {
  description = "Enable public IP for ECS instances"
  type        = bool
  default     = false
}

variable "ecs_allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access ECS instances"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "ecs_additional_security_group_ids" {
  description = "Additional security group IDs for ECS instances"
  type        = list(string)
  default     = []
}

# RDS Engine Configuration
variable "engine" {
  description = "Database engine"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
  default     = "8.0.41"
}

variable "major_engine_version" {
  description = "Major engine version for option group"
  type        = string
  default     = "8.0"
}

# RDS Instance Configuration
variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "reader_instance_class" {
  description = "RDS instance class for readers"
  type        = string
  default     = "db.t3.small"
}

# RDS Storage Configuration
variable "allocated_storage" {
  description = "RDS allocated storage"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "RDS max allocated storage"
  type        = number
  default     = 100
}

variable "storage_type" {
  description = "Storage type"
  type        = string
  default     = "gp2"
}

variable "storage_encrypted" {
  description = "Enable storage encryption"
  type        = bool
  default     = true
}

# RDS Network Configuration
variable "mysql_port" {
  description = "MySQL port"
  type        = number
  default     = 3306
}

variable "publicly_accessible" {
  description = "Make RDS instance publicly accessible"
  type        = bool
  default     = false
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
  default     = false
}

variable "allow_public_access" {
  description = "Allow public access to RDS (for dev/test environments)"
  type        = bool
  default     = false
}

# RDS Database Configuration
variable "db_username" {
  description = "The username for the RDS instance"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "The password for the RDS instance"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

# RDS Database Parameter Configuration
variable "max_connections" {
  description = "Maximum number of connections"
  type        = string
  default     = "1000"
}

variable "slow_query_log" {
  description = "Enable slow query log"
  type        = string
  default     = "1"
}

variable "long_query_time" {
  description = "Long query time threshold"
  type        = string
  default     = "2"
}

variable "general_log" {
  description = "Enable general log"
  type        = string
  default     = "1"
}

# RDS Backup Configuration
variable "backup_retention_period" {
  description = "RDS backup retention period"
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "Backup window"
  type        = string
  default     = "03:00-04:00"
}

variable "maintenance_window" {
  description = "Maintenance window"
  type        = string
  default     = "sun:04:00-sun:05:00"
}

variable "copy_tags_to_snapshot" {
  description = "Copy tags to snapshots"
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot when deleting"
  type        = bool
  default     = true
}

# RDS Monitoring Configuration
variable "monitoring_interval" {
  description = "RDS monitoring interval"
  type        = number
  default     = 0
}

variable "performance_insights_enabled" {
  description = "Enable Performance Insights"
  type        = bool
  default     = true
}

variable "performance_insights_retention_period" {
  description = "Performance Insights retention period in days"
  type        = number
  default     = 7
}

# RDS CloudWatch Logs Configuration
variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to export to CloudWatch"
  type        = list(string)
  default     = ["error", "general", "slowquery"]
}

variable "cloudwatch_log_retention_days" {
  description = "CloudWatch log retention period in days"
  type        = number
  default     = 7
}

# RDS Security Configuration
variable "kms_key_id" {
  description = "KMS key ID for encryption"
  type        = string
  default     = null
}

variable "secret_recovery_window_prod" {
  description = "Recovery window for secrets in production"
  type        = number
  default     = 30
}

variable "secret_recovery_window_non_prod" {
  description = "Recovery window for secrets in non-production"
  type        = number
  default     = 0
}

variable "deletion_protection_prod" {
  description = "Enable deletion protection for production"
  type        = bool
  default     = true
}

variable "deletion_protection_non_prod" {
  description = "Enable deletion protection for non-production"
  type        = bool
  default     = false
}

# RDS Auto Minor Version Upgrade
variable "auto_minor_version_upgrade" {
  description = "Enable auto minor version upgrade"
  type        = bool
  default     = true
}

# Deprecated Variables (kept for compatibility)
variable "reader_instance_count" {
  description = "Number of reader instances"
  type        = number
  default     = 2
}

variable "backtrack_window" {
  description = "Target backtrack window in hours (Aurora MySQL only)"
  type        = number
  default     = 0
}

variable "enable_auto_scaling" {
  description = "Enable auto scaling for Aurora read replicas"
  type        = bool
  default     = true
}

variable "auto_scaling_min_capacity" {
  description = "Minimum number of read replicas"
  type        = number
  default     = 1
}

variable "auto_scaling_max_capacity" {
  description = "Maximum number of read replicas"
  type        = number
  default     = 5
}

variable "auto_scaling_target_cpu" {
  description = "Target CPU utilization for auto scaling"
  type        = number
  default     = 70
}
variable "ecs_task_cpu" {
  description = "The number of CPU units used by the ECS task"
  type        = number
}

variable "ecs_task_memory" {
  description = "The amount of memory (in MiB) used by the ECS task"
  type        = number
}

variable "ecs_log_retention_days" {
  description = "Number of days to retain logs in CloudWatch"
  type        = number
}
