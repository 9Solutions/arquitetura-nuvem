resource "aws_security_group" "sg_access_webserver" {
  name        = "access-webserver-caixadesapato"
  description = "Acesso ao site do projeto"
  vpc_id      = aws_vpc.vpc_terraform.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }


  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "access-webserver-caixadesapato"
  }
}


resource "aws_security_group" "sg_access_api_rest" {
  name        = "access-api-rest-caixadesapato"
  description = "Acesso a API Spring Boot na porta 8080"
  vpc_id      = aws_vpc.vpc_terraform.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "access-api-rest-caixadesapato"
  }
}

resource "aws_security_group" "sg_gateway_lambda" {
  name        = "access-lambdas"
  description = "Acessar lambdas privados"
  vpc_id      = aws_vpc.vpc_terraform.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "access-lambdas"
  }
}


resource "aws_security_group" "sg_access_database" {
  name        = "access-database-caixadesapato"
  description = "Acesso ao banco de dados"
  vpc_id      = aws_vpc.vpc_terraform.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.128/25"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.128/25"]
  }

  tags = {
    Name = "access-database-caixadesapato"
  }

}
