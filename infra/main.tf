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
  user_data            = filebase64("ansible.sh")

  tags = {
    Name = "DjangoProjectMachineModel"
  }
  key_name = var.key
}

resource "aws_key_pair" "ssh_key" {
  key_name   = var.key
  public_key = file("${var.key}.pub")
}

resource "aws_autoscaling_group" "autoscaling_group" {
  name = var.autoscaling_group_name
  launch_template {
    id = aws_launch_template.app_machine_model.id
  }
  availability_zones = ["${var.aws_region}a"]
  min_size           = var.min_machines
  max_size           = var.max_machines
}
