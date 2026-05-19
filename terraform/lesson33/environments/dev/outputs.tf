output "ALBDnsName" {
  value = module.network.alb_dns_name
  description = "DNS name of ALB"
}

output "EC2PublicIP" {
  value       = module.compute.ec2_public_ip
  description = "Public IP of EC2"
}

output "RDSEndpoint" {
  value       = module.storage.rds_endpoint
  description = "Endpoint of RDS"
}

