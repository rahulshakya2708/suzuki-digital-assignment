resource "aws_lambda_function" "lambda" {
  function_name    = var.lambda_name
  role            = var.iam_role_arn
  handler         = "index.handler"
  runtime         = "python3.8"
  filename        = var.use_localstack ? null : "lambda_function.zip"
  source_code_hash = var.use_localstack ? null : filebase64sha256("lambda_function.zip")
  s3_bucket       = var.use_localstack ? "local-bucket" : null
  s3_key          = var.use_localstack ? "lambda_function.zip" : null
  timeout         = 10

  environment {
    variables = {
      DYNAMODB_TABLE = var.dynamodb_table_name
    }
  }
}

resource "aws_lambda_permission" "apigw" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"
}

# IAM Role moved to modules/iam/main.tf for better modularization

