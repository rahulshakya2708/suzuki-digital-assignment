variable "lambda_function_arn" {
  description = "Lambda function ARN"
}

variable "use_localstack" {
  description = "Flag for LocalStack usage"
  type        = bool
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}


