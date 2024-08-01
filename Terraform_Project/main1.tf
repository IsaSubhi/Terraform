provider "aws" {
  access_key = ""
  secret_key = ""
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "rtg-terraform-remote"
    key    = "dev/subhi/terraform.tfstate"
    region = "eu-central-1"
  }
}

#==============================================================

resource "aws_default_vpc" "default" {}

output "default_vpc_id" {
  value = aws_default_vpc.default.id
}

output "default_vpc_arn" {
  value = aws_default_vpc.default.arn
}

output "default_vpc_cidr" {
  value = aws_default_vpc.default.cidr_block
}
