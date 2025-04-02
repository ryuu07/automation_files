subnets = {
  vpc1 = [
    { cidr_block = "10.0.1.0/24", env = "dev" },
    { cidr_block = "10.0.2.0/24", env = "dev" }
  ]
  vpc2 = [
    { cidr_block = "10.1.1.0/24", env = "prod" },
    { cidr_block = "10.1.2.0/24", env = "prod" }
  ]
}
