resource "aws_internet_gateway" "ig" {
    vpc_id = data.aws_vpc.vpc

    tags = {
        Name = "IG"
    }
  
}

resource "aws_route_table" "route1" {
    vpc_id = data.aws_vpc.vpc

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.ig
    }

    route {
        ipv6_cidr_block = "::/0"
        gateway_id = aws_internet_gateway.ig
    }

    tags = {
      Name = "Route-table"
    }

}

resource "aws_subnet" "private-subnet" {
  vpc_id = data.aws_vpc.vpc
  cidr_block = "10.0.1.0/24"
  availability_zone = eu-west-1a
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet"
  }
}


resource "aws_route_table_association" "rt-sub" {
    subnet_id = aws_subnet.private-subnet
    route_table_id = aws_route_table.route1
  

}


provider "aws" {
  region = "eu-west-1"
}

resource "aws_lambda_function" "api_lambda" {
  filename         = "lambda_function.zip"
  function_name    = "api_lambda_function"
  role             = data.aws_iam_role.lambda
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
  timeout          = 60
  memory_size      = 128
  subnet_ids       = [aws_subnet.private_subnet.id]
  security_group_ids = [aws_security_group.lambda_sg.id]
  environment {
    variables = {
      SUBNET_ID = aws_subnet.private_subnet.id
      NAME = "Tushar Kamble"
      EMAIL = "tushars6016@gmail.com"
    }
  }
}


resource "aws_security_group" "lambda_sg" {
  name_prefix = "lambda_sg"
  vpc_id      = data.aws_vpc.vpc

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = data.aws_vpc.vpc
  cidr_block = "10.0.1.0/24"
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "./lambda_function.py"
  output_path = "lambda_function.zip"
}

locals {
  api_payload = jsonencode({
    subnet_id = aws_subnet.private_subnet.id,
    name = "Tushar Kamble",
    email = "tushars6016@gmail.com"
  })
}



