output "api_id" {
  value = aws_api_gateway_rest_api.api.id
}

output "api_url" {
  value = aws_api_gateway_stage.prod.invoke_url
}

output "api_zone_id" {
  value = aws_api_gateway_rest_api.api.id
}

output "apigw_regional_domain_name" {
  value = aws_api_gateway_domain_name.api.regional_domain_name
}

output "apigw_regional_zone_id" {
  value = aws_api_gateway_domain_name.api.regional_zone_id
}

