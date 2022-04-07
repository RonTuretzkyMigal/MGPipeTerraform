terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}
resource "aws_security_group" "derpy" {
  egress{
  from_port=0
  to_port=0
  protocol="-1"
  cidr_blocks=["0.0.0.0/0"]
  }
  tags = {
    type = "terraform-test-security-group"
  }
}

resource "aws_instance" "app_server" {
  ami             = "ami-0277b52859bac6f4b"
  instance_type   = "t2.micro"
  key_name        = "JainwindowsServer"
  user_data	= file("file.sh")
  security_groups = ["derpy"]

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

