# Basic Configuration
variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "database_subnet_ids" {
  description = "List of database subnet IDs"
  type        = list(string)
}

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group from VPC module"
  type        = string
}

variable "ecs_security_group_id" {
  description = "ECS security group ID"
  type        = string
}

# Engine Configuration
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

# Instance Configuration
variable "db_instance_class" {
  description = "RDS instance class for primary"
  type        = string
  default     = "db.t3.small"
}

variable "reader_instance_class" {
  description = "RDS instance class for read replicas"
  type        = string
  default     = "db.t3.small"
}

# Storage Configuration
variable "allocated_storage" {
  description = "Initial allocated storage in GB"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Maximum allocated storage in GB for autoscaling"
  type        = number
  default     = 100
}

variable "storage_type" {
  description = "Storage type"
  type        = string
  default     = "gp2"
}

variable "storage_encrypted" {
  type = bool
  description = "Enable storage encryption for RDS"
}


# Network Configuration
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
  default     = true
}

variable "allow_public_access" {
  description = "Allow public access to RDS (for dev/test environments)"
  type        = bool
  default     = false
}

# Database Configuration
variable "db_name" {
  description = "Database name"
  type        = string
  default     = "appdb"
}

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

# Database Parameter Configuration
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

# Backup Configuration
variable "backup_retention_period" {
  description = "Backup retention period in days"
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

# Monitoring Configuration
variable "monitoring_interval" {
  description = "Enhanced monitoring interval"
  type        = number
  default     = 60
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

# CloudWatch Logs Configuration
variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to export to CloudWatch"
  type        = list(string)
  default     = ["error", "general", "slow"]
}

variable "cloudwatch_log_retention_days" {
  description = "CloudWatch log retention period in days"
  type        = number
  default     = 7
}

# Security Configuration
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

# Auto Minor Version Upgrade
variable "auto_minor_version_upgrade" {
  description = "Enable auto minor version upgrade"
  type        = bool
  default     = true
}

# Deprecated Variables (kept for compatibility but not used)
variable "reader_instance_count" {
  description = "Number of reader instances (deprecated - now fixed at 2)"
  type        = number
  default     = 2
}

variable "backtrack_window" {
  description = "Target backtrack window in hours (deprecated - not available for MySQL)"
  type        = number
  default     = 0
}

variable "enable_auto_scaling" {
  description = "Enable auto scaling for read replicas (deprecated - not available for MySQL)"
  type        = bool
  default     = false
}

variable "auto_scaling_min_capacity" {
  description = "Minimum number of read replicas (deprecated)"
  type        = number
  default     = 1
}

variable "auto_scaling_max_capacity" {
  description = "Maximum number of read replicas (deprecated)"
  type        = number
  default     = 5
}

variable "auto_scaling_target_cpu" {
  description = "Target CPU utilization for auto scaling (deprecated)"
  type        = number
  default     = 70
}
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}