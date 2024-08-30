provider "aws" {
  access_key = ""
  secret_key = ""
  region = "eu-central-1"
}

resource "aws_instance" "ubuntu-1"{
    count = 2
    ami = "ami-0669b163befffbdfc"
    instance_type = "t2.micro"
    tags = {
    Name    = "My Ubuntu Server"
    Owner   = "Subhi"
    Project = "Terraform Lessons"
  }

}

resource "aws_instance" "ubuntu-2"{
    ami = "ami-0669b163befffbdfc"
    instance_type = "t2.micro"
    tags = {
    Name    = "My Ubuntu Server"
    Owner   = "Subhi"
    Project = "Terraform Lessons"
  }

}

resource "aws_instance" "ubuntu-3"{
    ami = "ami-0669b163befffbdfc"
    instance_type = "t2.micro"
    tags = {
    Name    = "My Ubuntu Server"
    Owner   = "Subhi"
    Project = "Terraform Lessons"
  }

}

