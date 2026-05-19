output "EC2PublicIP" {
  value       = module.compute.ec2_public_ip
  description = "Public IP of EC2"
}

output "RDSEndpoint" {
  value       = module.storage.rds_endpoint # 💡モジュール名（module "db" か module "storage" か）に合わせてください
  description = "Endpoint of RDS"
}