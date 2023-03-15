import requests

url = "https://2xfhzfbt31.execute-api.eu-west-1.amazonaws.com/candidate-email_serverless_lambda_stage/data"
headers = {'X-Siemens-Auth' : 'test'}

payload = {
  "subnet_id": "aws.private-subnet.id",
  "name": "Tushar_Kamble",
  "email": "tushars6016@gmail.com"
}

response = requests.post(url, headers=headers, json=payload)
if response.status_code == 200:
    print("Success! Status code: ", response.status_code)
else:
    print("Error! Status code: ", response.status_code)

print(response.text)