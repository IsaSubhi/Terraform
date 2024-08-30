provider "aws" {
  access_key = ""
  secret_key = ""
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "rtg-terraform-remote"         // Bucket where to SAVE Terraform State
    key    = "dev/subhi/terraform.tfstate"     // Object name in the bucket to SAVE Terraform State
    region = "eu-central-1"                 // Region where bycket created
  }
}

#==============================================================

resource "aws_default_vpc" "default" {} # This need to be added since AWS Provider + to get VPC id

output "default_vpc_id" {
  value = aws_default_vpc.default.id
}

output "default_vpc_arn" {
  value = aws_default_vpc.default.arn
}

output "default_vpc_cidr" {
  value = aws_default_vpc.default.cidr_block
}
