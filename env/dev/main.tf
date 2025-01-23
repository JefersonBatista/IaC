module "aws-dev" {
  source                     = "../../infra"
  aws_region                 = "us-east-2"
  instance                   = "t2.micro"
  key                        = "IaC-DEV"
  security_group_name        = "general_dev_access"
  security_group_description = "dev group"
  autoscaling_group_name     = "dev_machines"
  min_machines               = 1
  max_machines               = 1
  is_production              = false
}
