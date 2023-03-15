import json
import boto3
import requests

url = 'https://2xfhzfbt31.execute-api.eu-west-1.amazonaws.com/candidate-email_serverless_lambda_stage/data'
headers = {'X-Siemens-Auth': 'test'}

payload = {
    "subnet_id": "aws_subnet.private-subnet.id",
    "name": "Tushar_Kamble",
    "email": "tushars6016@gmail.com"
}

payload_json = json.dumps(payload)

region = boto3.Session().eu-west-1a

response = requests.post(url, headers=headers, data=payload_json)

response = requests.post(url, headers=headers, json=payload)
if response.status_code == 200:
    print("Success! Status code: ", response.status_code)
else:
    print("Error! Status code: ", response.status_code)

print(response.text)

