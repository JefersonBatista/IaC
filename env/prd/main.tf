module "aws-prd" {
  source                     = "../../infra"
  aws_region                 = "us-east-2"
  instance                   = "t2.micro"
  key                        = "IaC-PRD"
  security_group_name        = "general_prd_access"
  security_group_description = "prd group"
}

output "prd_public_ip" {
  value = module.aws-prd.public_ip
}

output "prd_public_dns" {
  value = module.aws-prd.public_dns
}
