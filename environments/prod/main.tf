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

  environment = var.environment
  account_id  = data.aws_caller_identity.current.account_id
}

# RDS Module
module "rds" {
  source = "../../modules/rds"

  environment            = var.environment
  vpc_id                = module.vpc.vpc_id
  database_subnet_ids   = module.vpc.database_subnet_ids
  ecs_security_group_id = module.ecs.ecs_tasks_security_group_id

  # RDS Configuration from variables
  db_instance_class         = var.db_instance_class
  allocated_storage         = var.allocated_storage
  max_allocated_storage     = var.max_allocated_storage
  multi_az                  = var.multi_az
  backup_retention_period   = var.backup_retention_period
  monitoring_interval       = var.monitoring_interval
}

# ECS Module
module "ecs" {
  source = "../../modules/ecs"

  environment           = var.environment
  vpc_id               = module.vpc.vpc_id
  public_subnet_ids    = module.vpc.public_subnet_ids
  private_subnet_ids   = module.vpc.private_subnet_ids
  ecr_repository_url   = module.ecr.repository_url
  aws_region           = var.aws_region
  db_password_secret_arn = module.rds.db_password_secret_arn

  # ECS Configuration from variables
  task_cpu           = var.task_cpu
  task_memory        = var.task_memory
  desired_count      = var.desired_count
  min_capacity       = var.min_capacity
  max_capacity       = var.max_capacity
  log_retention_days = var.log_retention_days
}