variable "my_ip" {
  type        = string
  description = "My Global IP Address for SSH"
}

variable "ec2_keypair" {
  type        = string
  description = "Key pair name for the EC2 instance"
}

variable "ec2_ami" {
  type        = string
  default     = "ami-0e668174d57c64015"
  description = "AMI ID for the EC2 instance"
}

variable "ec2_instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Instance type for the EC2 instance"
}

variable "db_password" {
  type        = string
  description = "Password for the RDS instance"
}

variable "db_engine_version" {
  type        = string
  default     = "8.0.46"
  description = "Engine version for the RDS instance"
}

variable "db_instance_class" {
  type        = string
  default     = "db.t3.micro"
  description = "Instance class for the RDS instance"
}

variable "alarm_email" {
  type        = string
  description = "Email address for the alarm notifications"
}