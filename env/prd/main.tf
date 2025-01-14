module "aws-prd" {
  source                     = "../../infra"
  aws_region                 = "us-east-2"
  instance                   = "t2.micro"
  key                        = "IaC-PRD"
  security_group_name        = "general_prd_access"
  security_group_description = "prd group"
  autoscaling_group_name     = "prd_machines"
  min_machines               = 1
  max_machines               = 10
}
