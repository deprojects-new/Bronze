import json

def lambda_handler(event, context):
    """
    Dummy Lambda to test AWS trigger.
    """
    print("Received event:", json.dumps(event))
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
