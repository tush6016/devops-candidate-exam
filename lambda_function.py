  import json
  import requests
   
  def lambda_handler(event, context):
    endpoint = event['endpoint']
    auth_header = event['auth_header']
    payload = event['payload']
    response = requests.post(endpoint, headers=eval(auth_header), data=payload)
    return {
        'statusCode': response.status_code,
        'body': response.text
    }

