output "vpc" {
  value = aws_vpc.vpc_terraform.id
}

output "public_subnet" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet" {
  value = aws_subnet.private_subnet.id
}

output "security_group_ids" {
  value = [
    aws_security_group.sg_access_webserver.id,
    aws_security_group.sg_access_api_rest.id,
    aws_security_group.sg_gateway_lambda.id,
    aws_security_group.sg_access_database.id,
  ]
}
