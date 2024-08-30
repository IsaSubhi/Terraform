# Provision highly available web in any region default VPC
# Update to Web Server will be via Green/Blue deployment strategy

provider "aws" {
  access_key = ""
  secret_key = ""
  region = var.region
  default_tags {          // will be added to all instanses
    tags = var.default_tags
  }
}

#---------------------------------------------------------------------------------------

resource "aws_default_vpc" "default" {}

resource "aws_default_subnet" "default_az1" {
  availability_zone = data.aws_availability_zones.working.names[0]
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = data.aws_availability_zones.working.names[1]
}

#---------------------------------------------------------------------------------------

resource "aws_security_group" "my_webserver" {
  name   = "WebServer Security Group"
  vpc_id = aws_default_vpc.default.id
  dynamic "ingress" {
    for_each = var.sg_allow_ports
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
  }
}

#---------------------------------------------------------------------------------------

resource "aws_launch_template" "WebServer" {
  name                   = "WebServer-LT"
  image_id               = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.my_instance_type
  vpc_security_group_ids = [ aws_security_group.my_webserver.id ]
  user_data              = filebase64("${path.module}/user_data.sh")
  tags = {
    Name = "WebServer-LT"
  }
}

resource "aws_autoscaling_group" "WebServer" {
  name                = "WebServer-ASG-Ver-${aws_launch_template.WebServer.latest_version}"
  min_size            = 2
  max_size            = 2
  min_elb_capacity    = 2
  health_check_type   = "ELB"
  vpc_zone_identifier = [ aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id ]
  target_group_arns   = [ aws_lb_target_group.WebServer.arn ]
  launch_template {
    id = aws_launch_template.WebServer.id
    version = aws_launch_template.WebServer.latest_version
  }
  lifecycle {
    create_before_destroy = true
  }
}

#---------------------------------------------------------------------------------------

resource "aws_lb" "WebServer" {
  name               = "WebServer-ALB"
  load_balancer_type = "application"
  security_groups    = [ aws_security_group.my_webserver.id ]
  subnets            = [ aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id ]
}

resource "aws_lb_target_group" "WebServer" {
  name                 = "WebServer-TG"
  vpc_id               = aws_default_vpc.default.id
  port                 = 80
  protocol             = "HTTP"
  deregistration_delay = 10
}

resource "aws_lb_listener" "http" {
  load_balancer_arn  = aws_lb.WebServer.arn
  port               = "80"
  protocol           = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.WebServer.arn
  }
}

#---------------------------------------------------------------------------------------
 
output "WebServer_LB_URL" {
  value = aws_lb.WebServer.dns_name
}