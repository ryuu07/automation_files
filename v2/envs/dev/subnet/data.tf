data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../vpc/terraform.tfstate"
  }
}

output "test" {
  value = data.terraform_remote_state.vpc.outputs.vpc_id.values
}