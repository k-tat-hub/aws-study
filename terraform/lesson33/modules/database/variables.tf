variable "vpc_id" {
  type        = string
  description = "VPC ID for the RDS security groups"
}

variable "ec2_sg_id" {
  type        = string
  description = "Security group ID of the EC2 for the RDS ingress source"
}

variable "subnet_private_a_id" {
  type        = string
  description = "Private subnet A ID for the RDS subnet group"
}

variable "subnet_private_c_id" {
  type        = string
  description = "Private subnet C ID for the RDS subnet group"
}

variable "db_password" {
  type        = string
  description = "Password for the RDS instance"
}

variable "db_engine_version" {
  type        = string
  description = "Engine version for the RDS instance"
}

variable "db_instance_class" {
  type        = string
  description = "Instance class for the RDS instance"
}