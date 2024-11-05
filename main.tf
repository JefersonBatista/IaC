terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0ea3c35c5c3284d82"
  instance_type = "t2.micro"

  tags = {
    Name = "BashCodeInstance"
  }
  key_name = "my-first-instance-key"
}
