variable "region" {
    description = "The AWS region to launch the resources."
    default = "ap-south-1"
}
variable "cidr_block" {
    default = "10.0.0.0/16"
}
variable "env" {
    default = "dev"
}
