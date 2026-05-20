output "ALBDnsName" {
  value       = module.network.alb_dns_name
  description = "DNS name of the ALB"
}

output "EC2PublicIP" {
  value       = module.compute.ec2_public_ip
  description = "Public IP of the EC2"
}

output "RDSEndpoint" {
  value       = module.database.rds_endpoint
  description = "Endpoint of the RDS"
}