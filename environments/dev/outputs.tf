# outputs.tf (Root Module)

# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.vpc.private_subnet_ids
}

output "database_subnet_ids" {
  description = "IDs of the database subnets"
  value       = module.vpc.database_subnet_ids
}

# ECR Outputs
output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = module.ecr.repository_url
}

output "ecr_repository_name" {
  description = "Name of the ECR repository"
  value       = module.ecr.repository_name
}

# ECS Outputs
output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = module.ecs.cluster_name
}

output "ecs_cluster_arn" {
  description = "ARN of the ECS cluster"
  value       = module.ecs.cluster_arn
}

output "ecs_cluster_id" {
  description = "ID of the ECS cluster"
  value       = module.ecs.cluster_id
}

output "ecs_capacity_provider_name" {
  description = "Name of the ECS capacity provider"
  value       = module.ecs.capacity_provider_name
}

output "autoscaling_group_name" {
  description = "Name of the Auto Scaling Group"
  value       = module.ecs.autoscaling_group_name
}

output "autoscaling_group_arn" {
  description = "ARN of the Auto Scaling Group"
  value       = module.ecs.autoscaling_group_arn
}

output "ecs_task_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  value       = module.ecs.ecs_task_execution_role_arn
}

output "ecs_task_role_arn" {
  description = "ARN of the ECS task role"
  value       = module.ecs.ecs_task_role_arn
}

output "ecs_instances_security_group_id" {
  description = "Security group ID for ECS instances"
  value       = module.ecs.ecs_instances_security_group_id
}

# RDS Outputs (Updated to match Aurora cluster outputs)
output "rds_cluster_endpoint" {
  description = "RDS Aurora cluster endpoint"
  value       = module.rds.cluster_endpoint
  sensitive   = true
}

output "rds_cluster_reader_endpoint" {
  description = "RDS Aurora cluster reader endpoint"
  value       = module.rds.cluster_reader_endpoint
  sensitive   = true
}

output "rds_cluster_id" {
  description = "RDS Aurora cluster ID"
  value       = module.rds.cluster_id
}

output "rds_cluster_port" {
  description = "RDS Aurora cluster port"
  value       = module.rds.cluster_port
}

output "rds_database_name" {
  description = "RDS Aurora cluster database name"
  value       = module.rds.cluster_database_name
}

output "rds_master_username" {
  description = "RDS Aurora cluster master username"
  value       = module.rds.cluster_master_username
  sensitive   = true
}

output "rds_security_group_id" {
  description = "Security group ID for RDS Aurora"
  value       = module.rds.security_group_id
}

output "rds_secret_arn" {
  description = "ARN of the secret containing the database password"
  value       = module.rds.secret_arn
}

# CloudWatch Outputs
output "cloudwatch_log_group_app" {
  description = "CloudWatch log group for application"
  value       = module.ecs.cloudwatch_log_group_app
}

output "cloudwatch_log_group_ecs_instances" {
  description = "CloudWatch log group for ECS instances"
  value       = module.ecs.cloudwatch_log_group_ecs_instances
}

# Environment Information
output "region" {
  description = "AWS region"
  value       = var.aws_region
}

output "environment" {
  description = "Environment name"
  value       = var.environment
}

# Information for GitHub Actions
output "github_actions_info" {
  description = "Key information for GitHub Actions deployment"
  value = {
    cluster_name              = module.ecs.cluster_name
    task_execution_role_arn   = module.ecs.ecs_task_execution_role_arn
    task_role_arn             = module.ecs.ecs_task_role_arn
    ecr_repository_url        = module.ecr.repository_url
    security_group_id         = module.ecs.ecs_instances_security_group_id
    private_subnet_ids        = module.vpc.private_subnet_ids
    log_group_name            = module.ecs.cloudwatch_log_group_app
    region                    = var.aws_region
    environment               = var.environment
    rds_cluster_endpoint      = module.rds.cluster_endpoint
    rds_cluster_port          = module.rds.cluster_port
    rds_database_name         = module.rds.cluster_database_name
    rds_secret_arn            = module.rds.secret_arn
  }
  sensitive = true
}