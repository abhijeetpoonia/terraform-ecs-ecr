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

variable "vpc_id" {
  description = "VPC ID where ECS resources will be created"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for ECS instances"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for ECS instances"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type for ECS instances"
  type        = string
}

variable "key_name" {
  description = "EC2 Key Pair name"
  type        = string
}

variable "min_capacity" {
  description = "Minimum number of instances in the Auto Scaling Group"
  type        = number
}

variable "max_capacity" {
  description = "Maximum number of instances in the Auto Scaling Group"
  type        = number
}

variable "desired_count" {
  description = "Desired number of instances in the Auto Scaling Group"
  type        = number
}

variable "log_retention_days" {
  description = "CloudWatch log retention in days"
  type        = number
}

variable "task_cpu" {
  description = "CPU units for the task"
  type        = number
}

variable "task_memory" {
  description = "Memory for the task"
  type        = number
}

variable "enable_detailed_monitoring" {
  description = "Enable detailed monitoring for ECS instances"
  type        = bool
}

variable "root_volume_size" {
  description = "Root volume size in GB"
  type        = number
}

variable "root_volume_type" {
  description = "Root volume type"
  type        = string
}


variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access ECS instances"
  type        = list(string)
}

variable "additional_security_group_ids" {
  description = "Additional security group IDs to attach to ECS instances"
  type        = list(string)
}
variable "user_data_template_vars" {
  description = "Additional template variables for the user data template"
  type        = map(string)
  default     = {}
}

variable "database_subnet_ids" {
  description = "List of database subnet IDs (if needed for ECS DB tasks)"
  type        = list(string)
  default     = []
}

