terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create an EC2 Instance
resource "aws_instance" "intro" {
  ami                    = "ami-0182f373e66f89c85"
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1a" # Specify a valid availability zone
  key_name               = "dove-key"
  vpc_security_group_ids = ["sg-0f6400533de19fa78"]
  tags = {
    Name = "Dove-Instance"
  }
}
