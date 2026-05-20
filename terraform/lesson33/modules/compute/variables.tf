variable "vpc_id" {
  type = string
  description = "VPC ID for the EC2 security groups"
}

variable "my_ip" { 
  type        = string
  description = "My Global IP Address for SSH"
}

variable "ec2_keypair" {
  type = string
  description = "Key pair name for the EC2 instance"
}

variable "ec2_ami" {
  type    = string
  default = "ami-0e668174d57c64015"
  description = "AMI ID for the EC2 instance"
}

variable "ec2_instance_type" {
  type    = string
  default = "t3.micro"
  description = "Instance type for the EC2 instance"
}

variable "subnet_public_a_id" {
  type = string
  description = "Public subnet A ID for the EC2 instance"
}

variable "alb_sg_id" {
  type = string
  description = "Security group ID of ALB for the EC2 ingress source"
}

