output "ec2_sg_id" {
  value = aws_security_group.ec2.id
  description = "Security group ID of the EC2"
}

output "ec2_public_ip" {
  value       = aws_instance.ec2.public_ip
  description = "Public IP of the EC2"
}

output "ec2_id" {
  value = aws_instance.ec2.id
  description = "Instance ID of the EC2"
}