# Terraform VPC Module

With this Terraform module, you can create desired number of VPCs with desired number of public and private subnets.

## Example Usage

1. Create a **main.tf** file and paste this code:

```
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
```
2. Create a **variables.tf** file (this is the place where you define your CIDR Blocks, subnets etc.) and paste this code:

```
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
```

3. Create a **outputs.tf** file and paste this code:

```
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
```

4. Initialize your working directory and download the necessary provider plugins: `terrform init`

5. Preview the changes that Terraform plans to make to your infrastructure: `terraform plan`

6. Execute the actions proposed in step-3: `terraform apply`

7. (Optional) Destroy everything when you done with working: `terraform destroy`
