module "titan_aws_vpc_module" {
  for_each = var.vpc
  source = "../../../modules/vpc"
  cidr_block = each.value.vpc_cidr
  instance_tenancy = each.value.instance_tenancy
  enable_dns_hostnames = each.value.enable_dns_hostnames
  enable_dns_support = each.value.enable_dns_support
  tags ={
    Name = each.value.vpc_name
  }
}