provider "aws" {
  region = var.region
}

module "subnet" {
  for_each = var.subnets
  source   = "../../../modules/subnet"
  vpc_id   = data.terraform_remote_state.vpc.outputs.vpc_id[each.key]

  ###
  env        = each.value.env
  cidr_block = each.value.cidr_block
}