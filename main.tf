terraform {
  backend "s3" {
    bucket                  = "my-terraform-state-bucket"
    key                     = "aws-infra/terraform.tfstate"
    region                  = "ap-northeast-1"
    endpoint                = "http://localhost:4566"
    access_key              = "test"
    secret_key              = "test"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
}


# Networking Module
module "networking" {
  source               = "./modules/networking"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24"]
  private_subnet_cidrs = ["10.0.2.0/24"]
}

# Route 53 Module
module "route53" {
  source       = "./modules/route53"
  domain       = "example.com"
  api_gw_id    = module.api_gateway.api_id
  api_gw_zone_id = module.api_gateway.api_zone_id
  apigw_regional_domain_name = module.api_gateway.apigw_regional_domain_name
  apigw_regional_zone_id     = module.api_gateway.apigw_regional_zone_id
}

# API Gateway Module
module "api_gateway" {
  source              = "./modules/api_gateway"
  lambda_function_arn = module.lambda.lambda_arn
  use_localstack      = var.use_localstack
}

# Lambda Module
module "lambda" {
  source              = "./modules/lambda"
  lambda_name         = "my_lambda"
  iam_role_arn        = module.iam.lambda_role_arn
  use_localstack      = var.use_localstack
  dynamodb_table_name = module.dynamodb.table_name
  table_name          = module.dynamodb.table_name
}

# IAM Module (for Lambda)
module "iam" {
  source = "./modules/iam"
  region               = var.region
  account_id           = var.account_id
  dynamodb_table_name  = module.dynamodb.table_name
  use_localstack = var.use_localstack
}

# DynamoDB Module
module "dynamodb" {
  source        = "./modules/dynamodb"
  table_name    = "my_table"
  #use_localstack = var.use_localstack
}

# EventBridge Module
module "eventbridge" {
  source              = "./modules/eventbridge"
  lambda_function_arn = module.lambda.lambda_arn
  use_localstack      = var.use_localstack
}

# Monitoring & Security Module
module "monitoring" {
  source               = "./modules/monitoring"
  lambda_function_name = module.lambda.lambda_name
  api_gateway_id       = module.api_gateway.api_id
  use_localstack       = var.use_localstack
}

