variable "region" {
  description = "The AWS region to deploy the VPC in"
  type        = string
  default     = "ap-south-1"
}
variable "subnets" {
  description = "A map of subnets configurations per VPC"
  type = map(list(object({
    cidr_block = string
    env        = string
  })))
}
