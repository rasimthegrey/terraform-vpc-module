output "vpc_ids" {
  value = { for k, v in module.vpc : k => v.vpc_id }
}

output "internet_gateway_ids" {
  value = { for k, v in module.vpc : k => v.internet_gateway_id }
}

output "public_route_table_ids" {
  value = { for k, v in module.vpc : k => v.public_route_table_id }
}

output "public_subnet_ids" {
  value = { for k, v in module.vpc : k => v.public_subnet_ids }
}

output "private_subnet_ids" {
  value = { for k, v in module.vpc : k => v.private_subnet_ids }
}