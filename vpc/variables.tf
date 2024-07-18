variable "region" {
  description = "AWS region to create resources in"
  type = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type = list(string)
  default = [ "10.0.1.0/24" ]
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  type = list(string)
  default = [ "10.0.2.0/24" ]
}

variable "name" {
  description = "Name prefix for resources"
  type = string
  default = ""
}