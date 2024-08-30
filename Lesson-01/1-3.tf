provider "aws" {
    access_key = ""
    secret_key = ""
    region = "eu-west-1"
}

resource "aws_instance" "my_Ubuntu" {
  ami           = "ami-090f10efc254eaf55"
  instance_type = "t2.micro"
  tags = {
    Name    = "My Ubuntu Server"
    Owner   = "Subhi"
    Project = "Terraform Lessons"
  }
}

resource "aws_instance" "my_Amazon" {
  ami           = "ami-03a71cec707bfc3d7"
  instance_type = "t2.small"
  tags = {
    Name    = "My Amazon Server"
    Owner   = "Subhi"
    Project = "Terraform Lessons"
  }
}
