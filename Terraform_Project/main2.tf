provider "aws" {
  access_key = ""
  secret_key = ""
  region = "eu-central-1"
}

data "terraform_remote_state" "testaform" {
  backend = "s3" 
  config = {
      bucket = "rtg-terraform-remote"
      key    = "dev/subhi/terraform.tfstate"
      region = "eu-central-1"
  }
}

resource "aws_security_group" "my_webserver" {
  name        = "WebServerSecurityGroup"
  description = "My First SecurityGroup"
  vpc_id      = data.terraform_remote_state.testaform.outputs.default_vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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


output "remote_outputs_details" {
  value =  data.terraform_remote_state.testaform
}

