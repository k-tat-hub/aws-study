variable "MyIP" {
  type        = string
  description = "My Global IP Address for SSH"
}

variable "ec2_keypair" {
  type = string
}

variable "ec2_ami" {
  type    = string
  default = "ami-0e668174d57c64015"
}

variable "ec2_instancetype" {
  type    = string
  default = "t3.micro"
}
