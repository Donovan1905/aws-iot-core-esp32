import boto3
import json

def lambda_handler(event, context):
    print(event)
    client = boto3.client('iot-data', region_name='eu-west-3')
    response = client.publish(
        topic='esp32/sub',
        qos=1,
        payload=json.dumps(
            {
                'command': 'reduce_value'
            }
        )
    )

    return response
