provider "aws" {
  access_key = ""
  secret_key = ""
  region = var.region
}

resource "aws_default_vpc" "default" {}

resource "aws_instance" "my_server" {
    count = length(var.name_list)
    ami                    = data.aws_ami.latest_amazon_linux.id
    instance_type          = var.my_instance_type
    vpc_security_group_ids = [aws_security_group.my_server.id]
    monitoring = var.is_monitoring
    user_data = templatefile("user_data.sh.tpl", {
    f_name = "Subhi",
    l_name = "Isa",
    names  = ["Ely", "Shay",  "John", "Donald" ]
  })
  tags = {
    Name = var.name_list[count.index]
    Name = "server-${count.index+1}"
  }
}

resource "aws_security_group" "my_server" {
  name        = "WebServer Security Group"
  description = "My First SecurityGroup"
  vpc_id      = aws_default_vpc.default.id

  dynamic "ingress" {
    for_each = var.allow_ports
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