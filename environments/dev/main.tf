# main.tf (Root Module) - FIXED

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "terraform"
    }
  }
}

# Get current AWS account ID
data "aws_caller_identity" "current" {}

# VPC Module
module "vpc" {
  source = "../../modules/vpc"

  environment             = var.environment
  vpc_cidr               = var.vpc_cidr
  public_subnet_cidrs    = var.public_subnet_cidrs
  private_subnet_cidrs   = var.private_subnet_cidrs
  database_subnet_cidrs  = var.database_subnet_cidrs
}

# ECR Module
module "ecr" {
  source = "../../modules/ecr"
  
  environment  = var.environment
  project_name = var.project_name
  account_id = data.aws_caller_identity.current.account_id
}

# ECS Module - FIXED variable name
module "ecs" {
  source = "../../modules/ecs"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region

  # VPC Configuration
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids

  # ECS Configuration
  instance_type               = var.instance_type
  key_name                    = var.key_name
  min_capacity                = var.min_capacity
  max_capacity                = var.max_capacity
  desired_count               = var.desired_count
  root_volume_size            = var.ecs_root_volume_size
  root_volume_type            = var.ecs_root_volume_type
  enable_detailed_monitoring  = var.ecs_enable_detailed_monitoring
  # FIXED: Change from ecs_enable_public_ip to enable_public_ip
  
  
  additional_security_group_ids = var.ecs_additional_security_group_ids
  allowed_cidr_blocks           = var.ecs_allowed_cidr_blocks

  # Required ECS Task Definitions
  task_cpu             = var.ecs_task_cpu
  task_memory          = var.ecs_task_memory
  log_retention_days   = var.ecs_log_retention_days

  depends_on = [module.vpc]
}

module "rds" {
  source = "../../modules/rds"
  
  # Basic Configuration
  environment               = var.environment
  vpc_id                   = module.vpc.vpc_id
  database_subnet_ids      = module.vpc.database_subnet_ids 
  storage_encrypted        = var.storage_encrypted
  ecs_security_group_id    = module.ecs.ecs_instances_security_group_id
  db_subnet_group_name     = module.vpc.db_subnet_group_name
  
  # Instance Configuration
  db_instance_class        = var.db_instance_class
  reader_instance_class    = var.reader_instance_class
  
  # Storage Configuration
  allocated_storage        = var.allocated_storage
  max_allocated_storage    = var.max_allocated_storage
  
  # Database Configuration
  db_username              = var.db_username     
  db_password              = var.db_password
  db_name                  = var.db_name
  
  # Backup Configuration
  backup_retention_period  = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window
  
  # Monitoring Configuration
  monitoring_interval                        = var.monitoring_interval
  performance_insights_enabled               = var.performance_insights_enabled
  performance_insights_retention_period     = var.performance_insights_retention_period
  
  # CloudWatch Logs Configuration
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  cloudwatch_log_retention_days   = var.cloudwatch_log_retention_days
  
  # Security Configuration
  kms_key_id                      = var.kms_key_id
   
  # Deprecated variables (passed for compatibility but not used)
  reader_instance_count    = var.reader_instance_count
  backtrack_window        = var.backtrack_window
  enable_auto_scaling     = var.enable_auto_scaling
  auto_scaling_min_capacity = var.auto_scaling_min_capacity
  auto_scaling_max_capacity = var.auto_scaling_max_capacity
  auto_scaling_target_cpu = var.auto_scaling_target_cpu
}