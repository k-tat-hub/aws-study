variable "vpc_id" {
  type = string
}

variable "MyIP" {
  type        = string
  description = "My Global IP Address for SSH"
}

variable "ec2_ami" {
  type    = string
  default = "ami-0e668174d57c64015"
}

variable "ec2_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "subnet_public_a_id" {
  type = string
}

variable "ec2_keypair" {
  type = string
}

