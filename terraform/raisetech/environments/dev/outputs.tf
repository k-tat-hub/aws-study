output "alb_dns_name" {
  value       = module.network.alb_dns_name
  description = "DNS name of the ALB"
}

output "ec2_public_ip" {
  value       = module.compute.ec2_public_ip
  description = "Public IP of the EC2"
}

output "rds_endpoint" {
  value       = module.database.rds_endpoint
  description = "Endpoint of the RDS"
}