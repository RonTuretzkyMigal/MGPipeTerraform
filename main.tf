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
  provisioner "remote-exec" {
    inline = [
      "touch hello.txt",
      "echo helloworld remote provisioner >> hello.txt",
    ]
  }
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("/home/ronturetzky/.ssh/aws_key")
      timeout     = "4m"
   }



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
  resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDUFtTKN0ehhlrt6/Oy4XKRhYyjS5zAbujfY8holzMTJSsK+KKbcw+Rbk9wgheAmH/oaSBQMWdLuVv0+dZoCqvZkPLsp+/L42s/L12qvvo/RPl4S/hcQD886j1QzM4wmzghDlPjp79icDpUgw3Amwos2lQ6IU+xrlp60WbTF8eyMuKEom2dIVbozuGUeQ3juSmBvNj1LT7HMxFxxGf9RnswIaRTzg3VFA2KVwy4wg8Qx7uJVf/aYpUh/FjucehHaBIcFfY6abVnh1r5CZMfN3DyKxzykIXtbb6gQpY3T/TkhJPM1wYmDt4erFV4u7upJjc2WhzBWchy95T2pOQLl8pT ronturetzky@ront"
}
}

