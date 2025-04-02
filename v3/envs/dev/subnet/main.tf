module "titan_aws_subnet_module" {
    for_each = var.subnets
    source = "s3://d-titan-repo/terraform/modules/subnet"
    vpc_id = values(module.titan_aws_vpc_module)[0].vpc_id  #Dynamic Allocation the format of the tfvars needs to be checked
    cidr_block = each.value.cidr_block
    availability_zone = each.value.availability_zone
    tags = {
        Name = each.value.subnet_name
    }
}