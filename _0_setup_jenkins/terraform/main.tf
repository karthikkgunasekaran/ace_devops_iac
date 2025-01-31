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

resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.private_key.public_key_openssh
}

resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins_sg"
  description = "Allow HTTP and SSH traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${local.my_ip}/32"]
  }

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

resource "aws_instance" "jenkins_server" {
  ami                         = var.ec2_config.ami
  instance_type               = var.ec2_config.instance_type
  key_name                    = aws_key_pair.key_pair.key_name
  vpc_security_group_ids      = [aws_security_group.jenkins_sg.id]
  associate_public_ip_address = var.ec2_config.associate_public_ip_address

  tags = {
    Name = var.ec2_config.name
  }

  provisioner "local-exec" {
    command = <<-EOT
      echo "[jenkins]" > ../playbooks/hosts.ini
      echo "jenkins_server ansible_host=${self.public_ip} ansible_user=ec2-user ansible_private_key_file=jenkins_server_key.pem" >> ../playbooks/hosts.ini
    EOT
  }
}

output "private_key" {
  value     = tls_private_key.private_key.private_key_pem
  sensitive = true
}

output "jenkins_server_public_ip" {
  value = aws_instance.jenkins_server.public_ip
}