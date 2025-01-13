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
  region  = var.aws_region
}

resource "aws_launch_template" "app_machine_model" {
  image_id             = "ami-0ea3c35c5c3284d82"
  instance_type        = var.instance
  security_group_names = [var.security_group_name]

  tags = {
    Name = "DjangoProjectMachineModel"
  }
  key_name = var.key
}

resource "aws_key_pair" "ssh_key" {
  key_name   = var.key
  public_key = file("${var.key}.pub")
}

output "public_ip" {
  value = aws_instance.app_server.public_ip
}

output "public_dns" {
  value = aws_instance.app_server.public_dns
}
