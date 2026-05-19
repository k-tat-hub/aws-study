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

variable "ec2_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "db_password" {
  type = string
}

variable "db_engine_version" {
  type    = string
  default = "8.0.46"
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "alarm_email" {
  type = string
}