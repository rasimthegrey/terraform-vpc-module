variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "public_subnet_count" {
  description = "The number of public subnets to create"
  type        = number
  default     = 1
}

variable "public_subnets_cidr_blocks" {
  description = "A list of CIDR blocks for the public subnets"
  type        = list(string)
}

variable "public_subnet_tags" {
  description = "A map of tags to assign to the public subnets"
  type        = map(string)
  default     = {}
}

variable "private_subnet_count" {
  description = "The number of private subnets to create"
  type        = number
  default     = 1
}

variable "private_subnets_cidr_blocks" {
  description = "A list of CIDR blocks for the private subnets"
  type        = list(string)
}

variable "private_subnet_tags" {
  description = "A map of tags to assign to the private subnets"
  type        = map(string)
  default     = {}
}

variable "public_route_table_tags" {
  description = "A map of tags to assign to the public route table"
  type        = map(string)
  default     = {}
}
