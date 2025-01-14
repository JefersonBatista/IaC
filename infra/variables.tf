variable "aws_region" {
  type = string
}

variable "key" {
  type = string
}

variable "instance" {
  type = string
}

variable "security_group_name" {
  type = string
}

variable "security_group_description" {
  type = string
}

variable "autoscaling_group_name" {
  type = string
}

variable "min_machines" {
  type = number
}

variable "max_machines" {
  type = number
}
