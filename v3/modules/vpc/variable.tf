variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}
variable "instance_tenancy" {
  description = "The instance tenancy option for the VPC."
  type        = string
}
variable "enable_dns_hostnames" {
  description = "Whether DNS hostnames are supported for the VPC."
  type        = bool
}
variable "enable_dns_support" {
  description = "Whether DNS resolution is supported for the VPC."
  type        = bool
}
variable "tags" {
  description = "A map of tags to assign to the VPC."
  type        = map(string)
  default     = {}
}