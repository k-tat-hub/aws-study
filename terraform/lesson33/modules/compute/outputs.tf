output "ec2_id" {
  value       = aws_instance.ec2.id
  description = "Instance ID of the EC2"
}

output "ec2_instance_type" {
  value       = aws_instance.ec2.instance_type
  description = "Instance type of the EC2 instance"
}

output "ec2_public_ip" {
  value       = aws_instance.ec2.public_ip
  description = "Public IP of the EC2 instance"
}

output "ec2_public_ip_enabled" {
  value       = aws_instance.ec2.associate_public_ip_address
  description = "Public IP association status of the EC2 instance"
}

output "ec2_sg_egress_rules" {
  value       = aws_security_group.ec2.egress
  description = "Egress rules of the EC2 security group"
}

output "ec2_sg_id" {
  value       = aws_security_group.ec2.id
  description = "Security group ID of the EC2"
}

output "ec2_sg_ingress_rules" {
  value       = aws_security_group.ec2.ingress
  description = "Ingress rules of the EC2 security group"
}

output "ec2_subnet_id" {
  value       = aws_instance.ec2.subnet_id
  description = "Subnet ID of the EC2 instance"
}