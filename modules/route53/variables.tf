variable "domain" {
  description = "The domain name for Route 53"
  type        = string
}

variable "api_gw_id" {
  description = "API Gateway ID for Route 53 alias"
  type        = string
}

variable "api_gw_zone_id" {
  description = "API Gateway Hosted Zone ID"
  type        = string
}

variable "apigw_regional_domain_name" {}
variable "apigw_regional_zone_id" {}

