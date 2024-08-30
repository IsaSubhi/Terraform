data "aws_availability_zones" "available" {}
data "aws_region" "current" {}
data "aws_vpc" "name" {}
data "aws_subnets" "available" {}

output "my_web_site_ip" {
  description = "Elatic IP address assigned to our WebSite"
  value = aws_eip.my_static_ip.public_ip
}

output "my_instance_id" {
  description = "Instance ID of our WebSite"
  value = aws_instance.my_webserver.id
}

output "my_instance_arn" {
  description = "Instance ARN of our WebSite"
  value = aws_instance.my_webserver.arn
}

output "my_sg_id" {
  description = "Security Group of our WebSite"
  value       = aws_security_group.my_webserver.id
}

output "my_instance_state" {
  description = "Instance state of our WebSite"
  value = aws_instance.my_webserver.instance_state
}

output "my_instance_ami" {
  description = "Instance AMI of our WebSite"
  value = aws_instance.my_webserver.ami
}

output "my_instance_type" {
  description = "Instance type of our WebSite"
  value = aws_instance.my_webserver.instance_type
}

output "aws_availability_zones" {
  description = "Names of the availabe Availability Zones"
  value = data.aws_availability_zones.available.names
}

output "aws_region" {
  description = "Information about current region"
  value = data.aws_region.current
}

output "aws_vpc_id" {
  description = "VPC ID"
  value = data.aws_vpc.name.id
}

output "aws_subnets" {
  description = "IDs of the available subnets"
  value = data.aws_subnets.available.ids
}
