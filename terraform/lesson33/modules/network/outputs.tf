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

output "alb_sg_id" {
  value       = aws_security_group.alb.id
  description = "Security group ID of the ALB"
}

output "subnet_private_a_id" {
  value       = aws_subnet.private_a.id
  description = "ID of the private subnet A"
}

output "subnet_private_c_id" {
  value       = aws_subnet.private_c.id
  description = "ID of the private subnet C"
}

output "subnet_public_a_id" {
  value       = aws_subnet.public_a.id
  description = "ID of the public subnet A"
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "ID of the VPC"
}