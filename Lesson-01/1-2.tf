provider "aws" {
    access_key = ""
    secret_key = ""
    region = "eu-west-1"
}

resource "aws_instance" "my-ubuntu" {
    count = 2
    ami = "ami-0694d931cee176e7d"
    instance_type = "t2.micro"
}
