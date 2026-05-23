output "db_engine" {
  value       = aws_db_instance.rds.engine
  description = "Engine of the database"
}

output "db_engine_version" {
  value       = aws_db_instance.rds.engine_version
  description = "Engine version of the database"
}

output "db_instance_class" {
  value       = aws_db_instance.rds.instance_class
  description = "Instance class of the RDS"
}

output "db_multi_az" {
  value       = aws_db_instance.rds.multi_az
  description = "Multi-AZ setting of the RDS"
}

output "db_publicly_accessible" {
  value       = aws_db_instance.rds.publicly_accessible
  description = "Public accessibility of the RDS"
}

output "db_storage_encrypted" {
  value       = aws_db_instance.rds.storage_encrypted
  description = "Storage encryption of the RDS"
}

output "rds_endpoint" {
  value       = aws_db_instance.rds.address
  description = "Endpoint of the RDS"
}

output "rds_sg_egress_rules" {
  value       = aws_security_group.rds.egress
  description = "Egress rules of the RDS security group"
}

output "rds_sg_ingress_rules" {
  value       = aws_security_group.rds.ingress
  description = "Ingress rules of the RDS security group"
}