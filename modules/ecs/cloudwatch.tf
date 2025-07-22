# modules/ecs/cloudwatch.tf

# CloudWatch Log Group for ECS Application
resource "aws_cloudwatch_log_group" "app" {
  name              = "/ecs/${var.environment}-app"
  retention_in_days = var.log_retention_days

  tags = {
    Name        = "${var.environment}-app-logs"
    Environment = var.environment
  }
}

# CloudWatch Log Group for ECS Instances
resource "aws_cloudwatch_log_group" "ecs_instances" {
  name              = "/aws/ec2/ecs-instances"
  retention_in_days = var.log_retention_days

  tags = {
    Name        = "${var.environment}-ecs-instances-logs"
    Environment = var.environment
  }
}

# CloudWatch Log Group for Auto Scaling
resource "aws_cloudwatch_log_group" "autoscaling" {
  name              = "/aws/autoscaling/${var.environment}"
  retention_in_days = var.log_retention_days

  tags = {
    Name        = "${var.environment}-autoscaling-logs"
    Environment = var.environment
  }
}
resource "aws_cloudwatch_log_group" "ecs_cluster" {
  name              = "/aws/ecs/${var.environment}-cluster"
  retention_in_days = var.log_retention_days

  tags = {
    Name        = "${var.environment}-ecs-cluster-logs"
    Environment = var.environment
  }
}
