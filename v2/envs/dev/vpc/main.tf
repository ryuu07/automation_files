provider "aws" {
  region = var.region
}

module "vpc" {
  for_each   = var.vpcs
  source     = "../../../modules/vpc"
  cidr_block = each.value.cidr_block
  env        = each.value.env
}

//Yes, that's correct! When you call a module in main.tf, you can only pass values for the variables that are explicitly defined in the module's variables.tf file (or wherever the variables are defined in the module). These variables act as inputs to the module, and they determine how the module behaves.