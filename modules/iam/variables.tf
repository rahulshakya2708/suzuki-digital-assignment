variable "use_localstack" {}

variable "region" {
  description = "The AWS region where resources will be deployed"
  type        = string
}

variable "account_id" {
  description = "The AWS account ID"
  type        = string
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}

