# Primary Instance Outputs
output "db_instance_endpoint" {
  description = "RDS MySQL primary instance endpoint"
  value       = aws_db_instance.main.endpoint
}

output "db_instance_id" {
  description = "RDS MySQL primary instance ID"
  value       = aws_db_instance.main.id
}

output "db_instance_arn" {
  description = "RDS MySQL primary instance ARN"
  value       = aws_db_instance.main.arn
}

output "db_instance_port" {
  description = "RDS MySQL primary instance port"
  value       = aws_db_instance.main.port
}

output "db_instance_resource_id" {
  description = "RDS MySQL primary instance resource ID"
  value       = aws_db_instance.main.resource_id
}

# Read Replica Outputs
output "replica_1_endpoint" {
  description = "RDS MySQL replica 1 endpoint"
  value       = aws_db_instance.replica_1.endpoint
}

output "replica_1_id" {
  description = "RDS MySQL replica 1 ID"
  value       = aws_db_instance.replica_1.id
}

output "replica_2_endpoint" {
  description = "RDS MySQL replica 2 endpoint"
  value       = aws_db_instance.replica_2.endpoint
}

output "replica_2_id" {
  description = "RDS MySQL replica 2 ID"
  value       = aws_db_instance.replica_2.id
}

# Database Configuration Outputs
output "db_name" {
  description = "RDS MySQL database name"
  value       = aws_db_instance.main.db_name
}

output "db_username" {
  description = "RDS MySQL master username"
  value       = aws_db_instance.main.username
  sensitive   = true
}

output "engine" {
  description = "Database engine"
  value       = aws_db_instance.main.engine
}

output "engine_version" {
  description = "Database engine version"
  value       = aws_db_instance.main.engine_version
}

# Security and Networking
output "security_group_id" {
  description = "Security group ID for RDS MySQL"
  value       = aws_security_group.rds.id
}

output "db_subnet_group_name" {
  description = "DB subnet group name"
  value       = aws_db_instance.main.db_subnet_group_name
}

# Secrets Manager
output "secret_arn" {
  description = "ARN of the secret containing the database password"
  value       = aws_secretsmanager_secret.db_password.arn
}

output "db_password_secret_arn" {
  description = "ARN of the secret containing the database password"
  value       = aws_secretsmanager_secret.db_password.arn
}

# Backward Compatibility Outputs (for Aurora-style naming)
output "cluster_id" {
  description = "RDS MySQL primary instance ID (for backward compatibility)"
  value       = aws_db_instance.main.id
}

output "cluster_endpoint" {
  description = "RDS MySQL primary instance endpoint (for backward compatibility)"
  value       = aws_db_instance.main.endpoint
}

output "cluster_reader_endpoint" {
  description = "RDS MySQL replica 1 endpoint (for backward compatibility)"
  value       = aws_db_instance.replica_1.endpoint
}

output "cluster_port" {
  description = "RDS MySQL primary instance port (for backward compatibility)"
  value       = aws_db_instance.main.port
}

output "cluster_master_username" {
  description = "RDS MySQL master username (for backward compatibility)"
  value       = aws_db_instance.main.username
}

output "cluster_database_name" {
  description = "RDS MySQL database name (for backward compatibility)"
  value       = aws_db_instance.main.db_name
}

# Additional Useful Outputs
output "replica_endpoints" {
  description = "List of all replica endpoints"
  value = [
    aws_db_instance.replica_1.endpoint,
    aws_db_instance.replica_2.endpoint
  ]
}

output "all_instance_ids" {
  description = "List of all instance IDs"
  value = [
    aws_db_instance.main.id,
    aws_db_instance.replica_1.id,
    aws_db_instance.replica_2.id
  ]
}

output "parameter_group_name" {
  description = "Parameter group name"
  value       = aws_db_parameter_group.main.name
}

output "option_group_name" {
  description = "Option group name"
  value       = aws_db_option_group.main.name
}