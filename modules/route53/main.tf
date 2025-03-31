resource "aws_route53_zone" "primary" {
  name = var.domain
}

resource "aws_route53_record" "api" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "api.example.com"
  type    = "A"

  alias {
    name                   = var.apigw_regional_domain_name  # ✅ Fixed reference
    zone_id                = var.apigw_regional_zone_id      # ✅ Fixed reference
    evaluate_target_health = false
  }
}

