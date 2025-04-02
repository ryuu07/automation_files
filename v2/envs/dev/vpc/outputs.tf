output "vpc_id" {
  value       = { for key, mod in module.vpc : key => mod.vpc_id }
  description = "A map of VPC IDs keyed by VPC name"
}