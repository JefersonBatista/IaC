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
  availability_zones = ["${var.aws_region}a", "${var.aws_region}b"]
  min_size           = var.min_machines
  max_size           = var.max_machines
  target_group_arns  = [aws_lb_target_group.target_group.arn]
}

resource "aws_default_subnet" "subnet_1" {
  availability_zone = "${var.aws_region}a"
}

resource "aws_default_subnet" "subnet_2" {
  availability_zone = "${var.aws_region}b"
}

resource "aws_lb" "load_balancer" {
  name     = "load_balancer"
  internal = false
  subnets  = [aws_default_subnet.subnet_1.id, aws_default_subnet.subnet_2.id]
}

resource "aws_default_vpc" "default" {}

resource "aws_lb_target_group" "target_group" {
  name     = "target_group"
  vpc_id   = aws_default_vpc.default.id
  protocol = "HTTP"
  port     = "8000"
}

resource "aws_lb_listener" "load_balancer_listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  protocol          = "HTTP"
  port              = "8000"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}
