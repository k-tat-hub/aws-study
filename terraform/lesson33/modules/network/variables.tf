variable "vpc_cidr" {
  type = string
  description = "CIDR block for the VPC"
}

variable "subnet_public_a_cidr" {
  type = string
  description = "CIDR block for the public subnet A"
}

variable "subnet_public_c_cidr" {
  type = string
  description = "CIDR block for the public subnet C"
}

variable "subnet_private_a_cidr" {
  type = string
  description = "CIDR block for the private subnet A"
}

variable "subnet_private_c_cidr" {
  type = string
  description = "CIDR block for the private subnet C"
}

variable "ec2_id" {
  type = string
  description = "Instance ID of EC2 for the ALB target group"
}