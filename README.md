# Terraform VPC Module

With this Terraform module, you can create a VPC with desired number of public and private subnets.

## Example Usage

1. Create a **main.tf** file and paste this code:

```
module "vpc" {
  source = "./vpc"
  name = "demo-vpc"
  region = "us-east-1"
  vpc_cidr = "10.0.0.0/16"
  public_subnets = [ "10.0.1.0/24", "10.0.2.0/24" ]
  private_subnets = ["10.0.11.0/24", "10.0.21.0/24"]
}
```

2. Initialize your working directory and download the necessary provider plugins: `terrform init`

3. Preview the changes that Terraform plans to make to your infrastructure: `terraform plan`

4. Execute the actions proposed in step-3: `terraform apply`

5. (Optional) Destroy everything when you done with working: `terraform destroy`
