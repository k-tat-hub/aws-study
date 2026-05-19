variable "vpc_cidr" {
  type        = string
  description = "VPC全体のCIDRブロック"
}

variable "subnet_public_a_cidr" {
  type        = string
  description = "パブリックサブネットAのCIDR"
}

variable "subnet_public_c_cidr" {
  type        = string
  description = "パブリックサブネットCのCIDR"
}

variable "subnet_private_a_cidr" {
  type        = string
  description = "プライベートサブネットAのCIDR"
}

variable "subnet_private_c_cidr" {
  type        = string
  description = "プライベートサブネットCのCIDR"
}

variable "ec2_id" {
  type        = string
}