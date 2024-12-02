module "aws-dev" {
  source     = "../../infra"
  aws_region = "us-east-2"
  instance   = "t2.micro"
  key        = "IaC-DEV"
}
