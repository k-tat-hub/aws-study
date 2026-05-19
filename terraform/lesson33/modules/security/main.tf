# ==========================================
# WAFの作成
# ==========================================
resource "aws_wafv2_web_acl" "web_acl" {
  name  = "lesson33-web-acl"
  scope = "REGIONAL"

  default_action {
    allow {}
  }

  # CommonRuleSet
  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      sampled_requests_enabled   = true
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesCommonRuleSet"
    }
  }

  # KnownBadInputs
  rule {
    name     = "AWSManagedRulesKnownBadInputs"
    priority = 2

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      sampled_requests_enabled   = true
      cloudwatch_metrics_enabled = true
      metric_name                = "KnownBadInputsMetric"
    }
  }

  visibility_config {
    sampled_requests_enabled   = true
    cloudwatch_metrics_enabled = true
    metric_name                = "lesson33-web-acl-metrics"
  }

  tags = { Name = "lesson33-web-acl" }
}

# WAFをALBに紐づけ
resource "aws_wafv2_web_acl_association" "waf_alb_assoc" {
  resource_arn = var.alb_arn
  web_acl_arn  = aws_wafv2_web_acl.web_acl.arn
}

# ==========================================
# CloudWatch Logsとの連携
# ==========================================
resource "aws_cloudwatch_log_group" "waf_log" {
  name              = "aws-waf-logs-lesson33"
  retention_in_days = 7
  tags              = { Name = "aws-waf-logs-lesson33" }
}

resource "aws_wafv2_web_acl_logging_configuration" "waf_logging" {
  log_destination_configs = [aws_cloudwatch_log_group.waf_log.arn]
  resource_arn            = aws_wafv2_web_acl.web_acl.arn
}