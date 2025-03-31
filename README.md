# suzuki-digital-assignment
suzuki-digital-assignment for terraform project

# README: Terraform AWS LocalStack Setup

## Overview
This project sets up an AWS infrastructure using Terraform and LocalStack, including Networking, IAM, route53, API Gateway, Lambda, EventBridge, DynamoDB, and CloudWatch Logs.

## Prerequisites
1. Install and run docker on your machine.
2. Setup LocalStack (I have installed using homebrew)
   command :  brew install localstack/tap/localstack-cli
3. Install tflocal - a wrapper for localstack to work with Terraform
   command : pip3 install terraform-local

- Run LocalStack -
  localstack start -d (detach mode)
  localstack status


### Export AWS Credentials for LocalStack (This ensures Terraform and AWS CLI use LocalStack correctly.)

export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
export AWS_ENDPOINT_URL=http://localhost:4566
export AWS_DEFAULT_REGION=ap-northeast-1
export AWS_REGION=ap-northeast-1


# clone assignemnet repository 

git clone https://github.com/rahulshakya2708/suzuki-digital-assignment.git   
cd suzuki-digital-assignment

### Create terraform state bucket
aws s3 mb s3://my-terraform-state-bucket --endpoint-url=http://localhost:4566

## initialize and Deployment infra using terraform
1. Initialize Terraform: tflocal init
2. Validate terraform : tflocal validate
3. Previewing Changes : tflocal plan
4. Apply Terraform configuration: tflocal apply -auto-approve


## Testing API Gateway and Lambda
1. Get the API Gateway endpoint:
   echo "http://localhost:4566/restapis/$(tflocal output -raw api_gateway_id)/prod/_user_request_/"

2. Invoke the Lambda via API Gateway:

   curl -X POST "http://localhost:4566/restapis/$(tflocal output -raw api_gateway_id)/prod/_user_request_/lambda" \
        -H "Content-Type: application/json" \
        -d '{}'

   Expected response:
   
   {"message": "Lambda executed successfully!"}

## Testing EventBridge and Lambda Trigger
1. Check scheduled rules:
   
   command : aws events list-rules --endpoint-url=http://localhost:4566
   
2. Manually trigger the rule:
   command : aws events put-events --endpoint-url=http://localhost:4566 --entries '[{"Source": "custom.event","DetailType": "ScheduledEvent","Detail": "{}","EventBusName": "default"}]'
   
3. Check Lambda execution logs as described in the CloudWatch section.

## Checking Data in DynamoDB
1. List DynamoDB tables:
   command : aws dynamodb list-tables --endpoint-url=http://localhost:4566

2. Scan the DynamoDB table:
   command : aws dynamodb scan --table-name my_table --endpoint-url=http://localhost:4566
   
3. check Dynamodb items:
   aws dynamodb get-item --table-name my_table \
  --key '{"id": {"S": "123"}}' \
  --endpoint-url=http://localhost:4566

## Checking CloudWatch Logs
1. List log groups:
   command : aws logs describe-log-groups --endpoint-url=http://localhost:4566
   
2. Tail Lambda logs:
   command : aws logs tail /aws/lambda/my_lambda --endpoint-url=http://localhost:4566 --follow
   


## Cleanup
To destroy all resources:  
command : tflocal destroy -auto-approve
