provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./vpc"

  for_each = var.vpcs

  vpc_cidr       = each.value.cidr_block
  public_subnets = each.value.public_subnets

  private_subnets = each.value.private_subnets
  tags                        = each.value.tags
  public_subnet_tags          = each.value.public_subnet_tags
  private_subnet_tags         = each.value.private_subnet_tags
  public_route_table_tags     = each.value.public_route_table_tags
}