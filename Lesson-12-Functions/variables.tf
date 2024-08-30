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

variable "is_monitoring" {
    description = "enter true to minitor or false to not"
    type = bool
    default = false  
}

variable "allow_ports" {
    description = "ports to open"
    type = list
    default = ["80", "443"]
}

variable "common_tags" {
    description = "tags"
    type = map
    default = {
        Owner = "Subhi"
        project = "Terraform"
        staging = "Dev"
    }
}

variable "name_list" {
    description = "list of names"
    type = list
    default = ["server-1", "server-2", "server-3"]
}