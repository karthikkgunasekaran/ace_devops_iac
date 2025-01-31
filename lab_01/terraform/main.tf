provider "aws" {
  region  = var.region
  default_tags {
    tags = {
      owner = var.owner
    }
  }
}

data "http" "my_ip" {
  url = "https://checkip.amazonaws.com/"
}

locals {
  my_ip = trimspace(data.http.my_ip.response_body)
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "lab_key" {
  key_name   = var.key_name
  public_key = tls_private_key.private_key.public_key_openssh
}

resource "aws_security_group" "lab_sg" {
  name        = "lab_01_sg"
  description = "Allow SSH traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${local.my_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "lab_instance" {
  ami                         = var.ec2_config.ami
  instance_type               = var.ec2_config.instance_type
  key_name                    = aws_key_pair.lab_key.key_name
  vpc_security_group_ids      = [aws_security_group.lab_sg.id]

  tags = {
    Name = "${var.ec2_config.name}_instance"
  }
}

output "instance_public_ip" {
  value = aws_instance.lab_instance.public_ip
}

output "private_key" {
  value     = tls_private_key.private_key.private_key_pem
  sensitive = true
}