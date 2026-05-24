output "web_acl_name" {
  value       = aws_wafv2_web_acl.main.name
  description = "Name of the WAF WebACL"
}