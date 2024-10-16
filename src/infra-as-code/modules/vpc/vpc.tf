resource "aws_vpc" "vpc_terraform" {
  cidr_block           = "10.0.0.0/24"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc-caixadesapato"
  }
}

resource "aws_internet_gateway" "igw-caixadesapato" {
  depends_on = [
    aws_vpc.vpc_terraform,
    aws_subnet.public_subnet_av1,
    aws_subnet.public_subnet_av2,
    aws_subnet.private_subnet
  ]

  vpc_id = aws_vpc.vpc_terraform.id

  tags = {
    Name = "igw-caixadesapato"
  }
}

resource "aws_route_table" "rtb_main_caixadesapato" {
  depends_on = [
    aws_vpc.vpc_terraform,
    aws_subnet.public_subnet_av1,
    aws_subnet.public_subnet_av2,
    aws_internet_gateway.igw-caixadesapato
  ]

  vpc_id = aws_vpc.vpc_terraform.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-caixadesapato.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.igw-caixadesapato.id
  }

  tags = {
    Name = "rtb-main-caixadesapato"
  }
}


resource "aws_route_table" "rtb_private_caixadesapato" {
  depends_on = [
    aws_vpc.vpc_terraform,
    aws_subnet.private_subnet
  ]

  vpc_id = aws_vpc.vpc_terraform.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-caixadesapato.id
  }

  tags = {
    Name = "rtb-private-caixadesapato"
  }
}
