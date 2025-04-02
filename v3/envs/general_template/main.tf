provider "aws" {
    region = "ap-south-1"
}

module "titan_aws_vpc_module" {
  for_each = var.vpc
  source = "../../modules/vpc"
  cidr_block = each.value.vpc_cidr
  instance_tenancy = each.value.instance_tenancy
  enable_dns_hostnames = each.value.enable_dns_hostnames
  enable_dns_support = each.value.enable_dns_support
  tags ={
    Name = each.value.vpc_name
  }
}
variable "vpc" {}
# output "vpc_ids" {
#   description = "Map of VPC IDs"
#   value       = { for k, v in module.titan_aws_vpc_module : k => v.vpc_id }
# }

# output "vpc_names" {
#   description = "Map of VPC Names"
#   value       = { for k, v in module.titan_aws_vpc_module : k => v.vpc_name }
# }
module "titan_aws_subnet_module" {
    for_each = var.subnet
    source = "../../modules/subnet"
    vpc_id = values(module.titan_aws_vpc_module)[0].vpc_id  #Dynamic Allocation the format of the tfvars needs to be checked
    cidr_block = each.value.subnet_cidr
    availability_zone = each.value.availability_zone
    tags = {
        Name = each.value.subnet_name
    }
}
variable "subnet" {}