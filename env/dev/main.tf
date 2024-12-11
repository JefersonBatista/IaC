module "aws-dev" {
  source     = "../../infra"
  aws_region = "us-east-2"
  instance   = "t2.micro"
  key        = "IaC-DEV"
}

output "dev_public_ip" {
  value = module.aws-dev.public_ip
}

output "dev_public_dns" {
  value = module.aws-dev.public_dns
}
