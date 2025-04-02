variable "cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
}
variable "vpc_id" {
  description = "VPC ID to associate the subnet with"
  type        = string
}
variable "availability_zone" {
  description = "Availability zone for the subnet"
  type        = string
}
variable "tags" {
  description = "Tags to apply to the subnet"
  type        = map(string)
  default     = {}
}
