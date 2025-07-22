# modules/ecr/outputs.tf

output "repository_url" {
  description = "ECR repository URL"
  value       = aws_ecr_repository.app.repository_url
}

output "repository_name" {
  description = "ECR repository name"
  value       = aws_ecr_repository.app.name
}

output "registry_id" {
  description = "ECR registry ID"
  value       = aws_ecr_repository.app.registry_id
}