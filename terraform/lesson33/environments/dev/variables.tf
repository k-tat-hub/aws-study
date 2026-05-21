variable "alarm_email" {
  type        = string
  description = "Email address for the alarm notifications"
}

variable "db_availability_zone" {
  type        = string
  description = "Availability zone for the RDS instance"
}

variable "db_engine_version" {
  type        = string
  description = "Engine version for the RDS instance"
}

variable "db_instance_class" {
  type        = string
  description = "Instance class for the RDS instance"
}

variable "db_multi_az" {
  type        = bool
  description = "Enable multi-AZ for the RDS instance"
}

variable "db_password" {
  type        = string
  description = "Password for the RDS instance"
}

variable "ec2_ami" {
  type        = string
  description = "AMI ID for the EC2 instance"
}

variable "ec2_instance_type" {
  type        = string
  description = "Instance type for the EC2 instance"
}

variable "ec2_keypair" {
  type        = string
  description = "Key pair name for the EC2 instance"
}

variable "my_ip" {
  type        = string
  description = "My Global IP Address for SSH"
}

variable "subnet_private_a_cidr" {
  type        = string
  description = "CIDR block for the private subnet A"
}

variable "subnet_private_c_cidr" {
  type        = string
  description = "CIDR block for the private subnet C"
}

variable "subnet_public_a_cidr" {
  type        = string
  description = "CIDR block for the public subnet A"
}

variable "subnet_public_c_cidr" {
  type        = string
  description = "CIDR block for the public subnet C"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}