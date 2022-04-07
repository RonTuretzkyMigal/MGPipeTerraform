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
  key_name        = "aws_key"
  user_data	= file("file.sh")
  vpc_security_group_ids = [aws_security_group.Docker.id]




  tags = {
    Name = "ExampleAppServerInstance"
  }
  }

  resource "aws_security_group" "Docker" {
   egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]

  tags = {
    type = "terraform-test-security-group"
  }

}

