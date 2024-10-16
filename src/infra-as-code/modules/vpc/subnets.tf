resource "aws_subnet" "public_subnet_av1" {
  depends_on = [aws_vpc.vpc_terraform]

  vpc_id                  = aws_vpc.vpc_terraform.id
  cidr_block              = "10.0.0.0/26"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "sub-pub-av1-caixadesapato"
  }
}

resource "aws_subnet" "public_subnet_av2" {
  depends_on = [aws_vpc.vpc_terraform]

  vpc_id                  = aws_vpc.vpc_terraform.id
  cidr_block              = "10.0.0.64/26"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true


  tags = {
    Name = "sub-pub-av2-caixadesapato"
  }
}


resource "aws_subnet" "private_subnet" {
  depends_on = [aws_vpc.vpc_terraform]

  vpc_id            = aws_vpc.vpc_terraform.id
  cidr_block        = "10.0.0.128/25"
  availability_zone = "us-east-1c"

  tags = {
    Name = "sub-pri-caixadesapato"
  }
}


resource "aws_route_table_association" "rta_public_subnet_1" {
  subnet_id = aws_subnet.public_subnet_av1.id
  route_table_id = aws_route_table.rtb_main_caixadesapato.id
}

resource "aws_route_table_association" "rta_public_subnet_2" {
  subnet_id = aws_subnet.public_subnet_av2.id
  route_table_id = aws_route_table.rtb_main_caixadesapato.id
}

resource "aws_route_table_association" "rta_private_subnet" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.rtb_private_caixadesapato.id
}
