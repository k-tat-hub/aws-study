# ==========================================
# SNSの設定
# ==========================================
resource "aws_sns_topic" "alarm" {
  name = "lesson33-alarm-topic"
  tags = {
    Name = "lesson33-alarm-topic"
  }
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alarm.arn
  protocol  = "email"
  endpoint  = var.alarm_email
}

# ==========================================
# アラームの作成
# ==========================================
# アラーム1: EC2のCPU使用率
resource "aws_cloudwatch_metric_alarm" "ec2_cpu" {
  alarm_name        = "lesson33-ec2-cpu-over"
  alarm_description = "EC2 CPU usage over 5%"
  metric_name       = "CPUUtilization"
  namespace         = "AWS/EC2"
  dimensions = {
    InstanceId = var.ec2_id
  }
  period              = 60
  statistic           = "Average"
  threshold           = 5
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  comparison_operator = "GreaterThanThreshold"
  treat_missing_data  = "notBreaching"

  alarm_actions = [
    aws_sns_topic.alarm.arn
  ]
}

# アラーム2: ALB 5XX エラー
resource "aws_cloudwatch_metric_alarm" "alb_5xx" {
  alarm_name        = "lesson33-alb-5xx-errors"
  alarm_description = "ALB 5XX Errors"
  metric_name       = "HTTPCode_ELB_5XX_Count"
  namespace         = "AWS/ApplicationELB"
  dimensions = {
    LoadBalancer = var.alb_arn_suffix
  }
  period              = 300
  statistic           = "Sum"
  threshold           = 10
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  comparison_operator = "GreaterThanThreshold"
  treat_missing_data  = "notBreaching"

  alarm_actions = [
    aws_sns_topic.alarm.arn
  ]
}

# アラーム3: WAF 不正アクセス検知
resource "aws_cloudwatch_metric_alarm" "waf_blocked" {
  alarm_name        = "lesson33-waf-blocked-requests"
  alarm_description = "WAF Blocked requests detected"
  metric_name       = "BlockedRequests"
  namespace         = "AWS/WAFV2"
  dimensions = {
    WebACL = var.web_acl_name
    Rule   = "ALL"
    Region = "ap-northeast-1"
  }
  period              = 60
  statistic           = "Sum"
  threshold           = 1
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  comparison_operator = "GreaterThanOrEqualToThreshold"
  treat_missing_data  = "notBreaching"

  alarm_actions = [
    aws_sns_topic.alarm.arn
  ]
}