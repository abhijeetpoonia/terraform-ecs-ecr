# modules/ecs/security_group.tf - Enhanced security group for ECS

# ECS Instances Security Group
resource "aws_security_group" "ecs_instances" {
  name        = "${var.project_name}-${var.environment}-ecs-instances-sg"
  description = "Security group for ECS instances"
  vpc_id      = var.vpc_id

  # Allow HTTP traffic
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS traffic
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH access (restrict this to your IP for security)
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  # Allow dynamic port mapping for containers (ECS uses these)
  ingress {
    description = "ECS Dynamic Port Mapping"
    from_port   = 32768
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # VPC CIDR for internal communication
  }

  # Allow communication within the VPC for ECS tasks
  ingress {
    description = "VPC Internal Communication"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  # Allow all outbound traffic (required for ECS agent communication)
  egress {
    description = "All Outbound Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-ecs-instances-sg"
    Environment = var.environment
    Project     = var.project_name
  }
}