output "vpc_id" {
  description = "value of the VPC ID"
  value       = aws_vpc.titan_aws_vpc.id
}

output "vpc_name" {
  description = "The Name tag of the VPC"
  value       = lookup(var.tags, "Name", "Unknown-VPC")
}
