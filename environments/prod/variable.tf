variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

# VPC Configuration
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "database_subnet_cidrs" {
  description = "CIDR blocks for database subnets"
  type        = list(string)
}

# RDS Configuration
variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
}

variable "max_allocated_storage" {
  description = "The upper limit to which Amazon RDS can automatically scale"
  type        = number
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
}

variable "monitoring_interval" {
  description = "The interval for collecting enhanced monitoring metrics"
  type        = number
}

# ECS Configuration
variable "task_cpu" {
  description = "The number of cpu units used by the task"
  type        = string
}

variable "task_memory" {
  description = "The amount of memory used by the task"
  type        = string
}

variable "desired_count" {
  description = "The number of instances of the task definition to place and keep running"
  type        = number
}

variable "min_capacity" {
  description = "The minimum number of tasks"
  type        = number
}

variable "max_capacity" {
  description = "The maximum number of tasks"
  type        = number
}

variable "log_retention_days" {
  description = "CloudWatch log retention in days"
  type        = number
}