resource "aws_subnet" "titan_aws_subnet" {
  cidr_block = var.cidr_block
  vpc_id = var.vpc_id
  availability_zone = var.availability_zone
  tags = {
    Name = var.tags["Name"]
  }
}