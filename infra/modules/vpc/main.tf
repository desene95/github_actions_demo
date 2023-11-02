resource "aws_vpc" "main" {
    #name = var.vpc_name
    cidr_block = var.cidr_block
    #location = var.location

    tags = {
        Name=var.vpc_name
    }
  
}

resource "aws_security_group" "allow_ssh"{
    name = "allow_ssh"
    vpc_id = aws_vpc.main.id

    ingress {
        description =   "SSH from internet"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks  = ["99.252.24.100/32"]

    }

    egress {
        from_port   =   0
        to_port     =   0
        protocol    =   "-1"
        cidr_blocks  =   ["0.0.0.0/0"]

    }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

output "vpc_id" {
    value = aws_vpc.main.id
}

output "sg_id" {
    value = aws_security_group.allow_ssh.id
}

output "igw_id" {
    value = aws_internet_gateway.igw.id
}

locals {
    #environment = "development"
    consumable = aws_vpc.main.id
}
output "consumable" {
  value       = local.consumable
  description = "The consumable object. It is the responsibility of the consumable to conceal sensitive attributes."
  sensitive   = false
}