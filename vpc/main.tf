// TODO: Module icinde kullanilan variable yapisini eskisi gibi tut ve for_each ile module blogunun icine ver
locals {
  create_vpc = var.create

  len_public_subnets = length(var.public_subnets)
  len_private_subnets = length(var.private_subnets)
}

resource "aws_vpc" "this" {
  count = local.create_vpc ? 1 : 0

  cidr_block = var.vpc_cidr

  tags = merge(
    { Name = var.name },
    var.tags
  )
}

locals {
  create_public_subnets = local.create_vpc && local.len_public_subnets > 0
}

resource "aws_subnet" "public" {
  count                   = local.create_public_subnets && (local.len_public_subnets >= length(var.availability_zones)) ? local.len_public_subnets : 0
  vpc_id                  = element(aws_vpc.this[*].id, count.index)
  cidr_block              = element(var.public_subnets, count.index)
  map_public_ip_on_launch = true

  tags = var.public_subnet_tags
}

locals {
  create_private_subnets = local.create_vpc && local.len_private_subnets > 0
}

resource "aws_subnet" "private" {
  count      = local.create_private_subnets && (local.len_private_subnets >= length(var.availability_zones)) ? local.len_private_subnets : 0
  vpc_id     = element(aws_vpc.this[*].id, count.index)
  cidr_block = element(var.private_subnets, count.index)

  tags = var.private_subnet_tags
}

resource "aws_internet_gateway" "this" {
  count = length(aws_vpc.this[*].id)
  vpc_id = element(aws_vpc.this[*].id, count.index)

  tags = var.tags
}

resource "aws_route_table" "public" {
  count = local.len_public_subnets
  vpc_id = element(aws_vpc.this[*].id, count.index)

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = element(aws_internet_gateway.this[*].id, count.index)
  }

  tags = var.public_route_table_tags
}

resource "aws_route_table_association" "public" {
  count          = local.len_private_subnets
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = element(aws_route_table.public[*].id, count.index)
}