resource "aws_subnet" "private" {
    cidr_block = var.cidr_block
    vpc_id = var.vpc_id
    tags = {
      "Name" = "${var.env}-private -subnet"
    }
}