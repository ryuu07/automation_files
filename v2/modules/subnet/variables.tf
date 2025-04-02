variable "region" {
    description = "The AWS region to launch the resources."
    default = "ap-south-1"
}
variable "cidr_block" {
    default = "10.0.0.0/19"
}
variable "env" {
    default = "dev"
}

variable "vpc_id" {
    description = "The ID of the VPC to create the subnet in."
    type        = string
}