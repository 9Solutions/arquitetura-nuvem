resource "aws_instance" "web_server_1" {
    ami = "ami-0866a3c8686eaeeba"
    instance_type = "t2.medium"
    key_name = "access-webserver"

    subnet_id = var.public_subnet_1
    associate_public_ip_address = true
    security_groups = [var.security_group_webserver]

    ebs_block_device {
      device_name = "/dev/sda1"
      volume_size = 30
      volume_type = "gp3"
    }

    tags = {
      Name = "web-server-1"
    }
}

resource "aws_instance" "web_server_2" {
    ami = "ami-0866a3c8686eaeeba"
    instance_type = "t2.medium"
    key_name = "access-webserver"

    ebs_block_device {
      device_name = "/dev/sda1"
      volume_size = 30
      volume_type = "gp3"
    }

    subnet_id = var.public_subnet_2
    associate_public_ip_address = true
    security_groups = [var.security_group_webserver]

    tags = {
        Name = "web-server-2"
    }
}

resource "aws_instance" "api_server" {
    ami = "ami-0866a3c8686eaeeba"
    instance_type = "t2.medium"
    key_name = "access-webserver"

    ebs_block_device {
      device_name = "/dev/sda1"
      volume_size = 50
      volume_type = "gp3"
      tags = {
        Name = "volume-backend"
      }
    }

    subnet_id = var.private_subnet
    associate_public_ip_address = true
    security_groups = [var.security_group_api]

    tags = {
        Name = "api-server"
    }
}