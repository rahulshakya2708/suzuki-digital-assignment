output "zone_id" {
  value = aws_route53_zone.primary.zone_id
}

output "api_record_name" {
  value = aws_route53_record.api.name
}

