output "vpc_ids" {
  description = "Map of VPC IDs"
  value       = { for k, v in module.titan_aws_vpc_module : k => v.vpc_id }
}

output "vpc_names" {
  description = "Map of VPC Names"
  value       = { for k, v in module.titan_aws_vpc_module : k => v.vpc_name }
}
