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
  region  = "us-west-2"
}

resource "aws_instance" "app_server" {
  ami             = "ami-00ee4df451840fa9d"
  instance_type   = "t2.micro"
  key_name        = "pair_test"
  user_data	= file("file.sh")

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

