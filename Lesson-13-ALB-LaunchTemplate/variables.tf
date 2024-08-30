variable "region" {
  description = "Wich region?"
  type = string
  default = "eu-central-1"
}

variable "my_instance_type" {
    description = "Instance type"
    type = string
    default = "t2.micro"
}

variable "sg_allow_ports" {
    description = "ports to open"
    type = list
    default = ["80", "443"]
}

variable "default_tags" {
    description = "default tags"
    type = map
    default = {
        Owner = "Subhi"
        Project = "Terraform"
        Class = "DevOps"
    }
}