output "vpc_id" {
  value = module.networking.vpc_id
}

output "lambda_arn" {
  value = module.lambda.lambda_arn
}

output "dynamodb_table_name" {
  value = module.dynamodb.table_name
}

output "api_gateway_id" {
  value = module.api_gateway.api_id
}

output "eventbridge_rule_name" {
  value = module.eventbridge.event_rule_name
}

output "cloudwatch_logs_lambda" {
  value = module.monitoring.lambda_log_group
}

output "cloudwatch_logs_apigw" {
  value = module.monitoring.api_gateway_log_group
}

