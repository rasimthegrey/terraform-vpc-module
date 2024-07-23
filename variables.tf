variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "eu-north-1"
}

variable "vpcs" {
  description = "A map of VPC configurations"
  type = map(object({
    cidr_block                  = string
    public_subnets_cidr_blocks  = list(string)
    private_subnets_cidr_blocks = list(string)
    tags                        = map(string)
    public_subnet_tags          = map(string)
    private_subnet_tags         = map(string)
    public_route_table_tags     = map(string)
  }))
  default = {
    vpc1 = {
      cidr_block                  = "10.0.0.0/16"
      public_subnets_cidr_blocks  = ["10.0.10.0/24", "10.0.20.0/24"]
      private_subnets_cidr_blocks = ["10.0.11.0/24", "10.0.21.0/24"]
      tags                        = { Name = "vpc1" }
      public_subnet_tags          = { Name = "vpc1-public" }
      private_subnet_tags         = { Name = "vpc1-private" }
      public_route_table_tags     = { Name = "vpc1-public-route-table" }
    }
    vpc2 = {
      cidr_block                  = "10.1.0.0/16"
      public_subnets_cidr_blocks  = ["10.1.1.0/24"]
      private_subnets_cidr_blocks = ["10.1.2.0/24"]
      tags                        = { Name = "vpc2" }
      public_subnet_tags          = { Name = "vpc2-public" }
      private_subnet_tags         = { Name = "vpc2-private" }
      public_route_table_tags     = { Name = "vpc2-public-route-table" }
    }
  }
}
