import json
import boto3
import os

dynamodb = boto3.resource("dynamodb")
table_name = os.environ.get("DYNAMODB_TABLE")
table = dynamodb.Table(table_name)

def handler(event, context):
    print("Received event:", json.dumps(event))

    # Example: Writing data to DynamoDB
    response = table.put_item(
        Item={
            "id": "123",
            "message": "Hello from Lambda!"
        }
    )

    return {
        "statusCode": 200,
        "body": json.dumps({"message": "Lambda executed successfully!"})
    }

