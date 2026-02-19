variable "aws_region" {
  description = "The AWS region where resources will be managed"
  type        = string
  default     = "us-east-2"
}

variable "project_name" {
  description = "The name of your startup"
  type        = string
}


variable "project" {
  default = "northwind"
  type        = string
}

variable "vpc_cidr" {
  type    = string
  default = "192.168.0.0/16"
}
variable "azs" {
  type    = list(string)
  default = []
}

variable "db_name" {
  type    = string
  default = "northwind"
}

variable "db_username" {
  type    = string
  default = "northwind_admin"
}


variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}
