output "cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.main.name
}

output "cluster_arn" {
  description = "ARN of the ECS cluster"
  value       = aws_ecs_cluster.main.arn
}

output "cluster_id" {
  description = "ID of the ECS cluster"
  value       = aws_ecs_cluster.main.id
}

output "capacity_provider_name" {
  description = "Name of the ECS capacity provider"
  value       = aws_ecs_capacity_provider.main.name
}

output "autoscaling_group_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.ecs_asg.name
}

output "autoscaling_group_arn" {
  description = "ARN of the Auto Scaling Group"
  value       = aws_autoscaling_group.ecs_asg.arn
}

output "ecs_instances_security_group_id" {
  description = "Security group ID for ECS instances"
  value       = aws_security_group.ecs_instances.id
}

output "ecs_instance_role_arn" {
  description = "ARN of the ECS instance role"
  value       = aws_iam_role.ecs_instance_role.arn
}

output "ecs_task_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_task_role_arn" {
  description = "ARN of the ECS task role"
  value       = aws_iam_role.ecs_task_role.arn
}

output "cloudwatch_log_group_app" {
  description = "CloudWatch log group for application"
  value       = aws_cloudwatch_log_group.app.name
}

output "cloudwatch_log_group_ecs_instances" {
  description = "CloudWatch log group for ECS instances"
  value       = aws_cloudwatch_log_group.ecs_instances.name
}
