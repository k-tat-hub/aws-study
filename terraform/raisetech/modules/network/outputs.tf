output "alb_arn" {
  value       = aws_lb.alb.arn
  description = "ARN of the ALB"
}

output "alb_arn_suffix" {
  value       = aws_lb.alb.arn_suffix
  description = "ARN suffix of the ALB"
}

output "alb_dns_name" {
  value       = aws_lb.alb.dns_name
  description = "DNS name of the ALB"
}

output "alb_sg_egress_rules" {
  value       = aws_security_group.alb.egress
  description = "Egress rules of the ALB security group"
}

output "alb_sg_id" {
  value       = aws_security_group.alb.id
  description = "Security group ID of the ALB"
}

output "alb_sg_ingress_rules" {
  value       = aws_security_group.alb.ingress
  description = "Ingress rules of the ALB security group"
}

output "subnet_private_a_cidr" {
  value       = aws_subnet.private_a.cidr_block
  description = "CIDR block of the private subnet a"
}

output "subnet_private_a_id" {
  value       = aws_subnet.private_a.id
  description = "ID of the private subnet a"
}

output "subnet_private_c_cidr" {
  value       = aws_subnet.private_c.cidr_block
  description = "CIDR block of the private subnet c"
}

output "subnet_private_c_id" {
  value       = aws_subnet.private_c.id
  description = "ID of the private subnet c"
}

output "subnet_public_a_cidr" {
  value       = aws_subnet.public_a.cidr_block
  description = "CIDR block of the public subnet a"
}

output "subnet_public_a_id" {
  value       = aws_subnet.public_a.id
  description = "ID of the public subnet a"
}

output "subnet_public_c_cidr" {
  value       = aws_subnet.public_c.cidr_block
  description = "CIDR block of the public subnet c"
}

output "vpc_cidr" {
  value       = aws_vpc.main.cidr_block
  description = "CIDR block of the VPC"
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "ID of the VPC"
}