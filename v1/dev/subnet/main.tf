resource "aws_subnet" "private" {
    cidr_block = var.cidr_block
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
    tags = {
      "Name" = "${var.env}-private -subnet"
    }
}

data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../vpc/terraform.tfstate"
  }
}

output "test" {
  value = data.terraform_remote_state.vpc
}