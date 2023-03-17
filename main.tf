resource "aws_subnet" "private_subnet" {
  vpc_id = data.aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Subnet"
  }
}


resource "aws_route_table" "private_rt" {
  vpc_id = data.aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = data.aws_nat_gateway.nat.id
  }
}

resource "aws_route_table_association" "private_rta" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_lambda_function" "example_lambda" {
  filename      = "lambda.zip"
  function_name = "lambda_function"
  role          = data.aws_iam_role.lamda..id
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  timeout       = 300

  vpc_config {
    subnet_ids         = aws_subnet.private_subnet.id
    security_group_ids = aws_security_group.lambda_sg.id
  }

  environment {
    variables = {
      api_endpoint = "https://2xfhzfbt31.execute-api.eu-west-1.amazonaws.com/candidate-email_serverless_lambda_stage/data"
      auth_header  = "test"
      name         = Tushar_Kamble
      email        = tushars6016@gmail.com
      subnet_id    = aws_subnet.private_subnet.id
    }
  }

  depends_on = [
    aws_security_group.lambda_sg
  ]
}



resource "aws_security_group" "lambda_sg" {
  name_prefix = "lambda_sg_"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    protocol = "tcp"
    from_port = 0
    to_port   = 65535
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol = "tcp"
    from_port = 0
    to_port   = 65535
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "./lambda_function.py"
  output_path = "./lambda_function.zip"
}

locals {
  api_payload = jsonencode({
    subnet_id = aws_subnet.private_subnet.id,
    name = "Tushar Kamble",
    email = "tushars6016@gmail.com"
  })
}

