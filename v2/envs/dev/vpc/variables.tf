variable "region" {
  description = "The AWS region to deploy the VPC in"
  type        = string
  default     = "ap-south-1"
}
variable "vpcs" {
  description = "A map of VPC configurations"
  type = map(object({
    cidr_block = string
    env        = string
  }))
}