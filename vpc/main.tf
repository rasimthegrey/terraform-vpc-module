// TODO: Module icinde kullanilan variable yapisini eskisi gibi tut ve for_each ile module blogunun icine ver
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "public" {
  count                   = var.public_subnet_count
  vpc_id                  = aws_vpc.this.id
  cidr_block              = element(var.public_subnets_cidr_blocks, count.index)
  map_public_ip_on_launch = true

  tags = var.public_subnet_tags
}

resource "aws_subnet" "private" {
  count      = var.private_subnet_count
  vpc_id     = aws_vpc.this.id
  cidr_block = element(var.private_subnets_cidr_blocks, count.index)

  tags = var.private_subnet_tags
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = var.tags
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = var.public_route_table_tags
}

resource "aws_route_table_association" "public" {
  count          = var.public_subnet_count
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}