output "event_rule_name" {
  value = aws_cloudwatch_event_rule.every_30_minutes.name
}
