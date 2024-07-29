import boto3


def lambda_handler(event, context):
    cloudwatch = boto3.client('cloudwatch')
    print(event)
    hall = event['hall']

    response = cloudwatch.put_metric_data(
        Namespace='esp32/pub',
        MetricData=[
            {
                'MetricName': 'Hall',
                'Dimensions': [
                    {
                        'Name': 'DeviceId',
                        'Value': 'ESP32'
                    },
                ],
                'Value': hall,
                'Unit': 'None'
            },
        ]
    )

    return response
