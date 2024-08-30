provider "aws" {
  access_key = ""
  secret_key = ""
  region = "eu-central-1"
}

resource "aws_default_vpc" "default" {} # This need to be added since AWS Provider to get VPC id

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_webserver.id
#  vpc      = true # Need to add in new AWS Provider version
  tags = {
    Name  = "Web Server EIP"
    Owner = "Subhi"
  }
}

resource "aws_instance" "my_webserver" {
  ami                    = "ami-07ab3281411d31d04"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data = templatefile("user_data.tpl", {
    f_name = "Subhi",
    l_name = "Isa",
    names  = ["Ely", "Shay",  "John", "Donald" ]
  })
  user_data_replace_on_change = true # Added in the new AWS provider!
  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "Subhi"
    Project = "Calsswork"
  }

  lifecycle {
    create_before_destroy = true
    #ignore_changes = [ tags, instance_type ]
  }
}

resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "My First SecurityGroup"
  vpc_id      = aws_default_vpc.default.id # This need to be added since AWS Provider  to set VPC id

  dynamic "ingress" {
    for_each = ["80", "443", "8080"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Web Server SecurityGroup"
    Owner = "Subhi"
  }
}
