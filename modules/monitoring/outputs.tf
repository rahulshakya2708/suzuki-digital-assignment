output "lambda_log_group" {
  value = aws_cloudwatch_log_group.lambda_logs.name
}

output "api_gateway_log_group" {
  value = aws_cloudwatch_log_group.api_gateway_logs.name
}

