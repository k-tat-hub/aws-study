variable "alarm_email" {
  type        = string
  description = "Email address for the alarm notifications"
}

variable "alb_arn_suffix" {
  type        = string
  description = "ARN suffix of ALB for the ALB 5xx alarm"
}

variable "ec2_id" {
  type        = string
  description = "Instance ID of EC2 for the EC2 CPU alarm"
}

variable "web_acl_name" {
  type        = string
  description = "Name of WAF WebACL for the WAF blocked alarm"
}