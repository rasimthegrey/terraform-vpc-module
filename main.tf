provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./vpc"

  for_each = var.vpcs

  vpc_cidr                    = each.value.cidr_block
  public_subnet_count         = length(each.value.public_subnets_cidr_blocks)
  public_subnets_cidr_blocks  = each.value.public_subnets_cidr_blocks
  private_subnet_count        = length(each.value.private_subnets_cidr_blocks)
  private_subnets_cidr_blocks = each.value.private_subnets_cidr_blocks
  tags                        = each.value.tags
  public_subnet_tags          = each.value.public_subnet_tags
  private_subnet_tags         = each.value.private_subnet_tags
  public_route_table_tags     = each.value.public_route_table_tags
}