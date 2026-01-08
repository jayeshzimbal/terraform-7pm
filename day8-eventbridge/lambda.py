def lambda_handler(event, context):
    print("Hello from EventBridge!")
    print("Event received:", event)
    return {
        'statusCode': 200,
        'body': 'Triggered successfully'
    }
