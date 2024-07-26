variable "create" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type = bool
  default = true
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "vpc_cidr" {
  description = "The IPv4 CIDR block for the VPC"
  type        = string
  default = "10.0.0.0/16"
}
variable "availability_zones" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

# Public Subnets

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "map_public_ip_on_launch" {
  description = "Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is `false`"
  type        = bool
  default     = false
}

variable "public_route_table_tags" {
  description = "A map of tags to assign to the public route table"
  type        = map(string)
  default     = {}
}

variable "public_subnet_tags" {
  description = "A map of tags to assign to the public subnets"
  type        = map(string)
  default     = {}
}


# Private Subnets

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "private_subnet_tags" {
  description = "A map of tags to assign to the private subnets"
  type        = map(string)
  default     = {}
}

variable "private_route_table_tags" {
  description = "Additional tags for the private route tables"
  type        = map(string)
  default     = {}
}

# NAT Gateways

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = false
}