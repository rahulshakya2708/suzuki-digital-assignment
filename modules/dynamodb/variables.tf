variable "table_name" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "use_localstack" {
  description = "Flag to use LocalStack"
  type        = bool
  default     = false
}

