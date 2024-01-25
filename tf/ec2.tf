provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "demo-instance" {
  ami = "ami-0a3c3a20c09d6f377"
  instance_type = "t2.medium"
  key_name = "first_instance"
}
resource "aws_security_group" "demo_sg" {
  name        = "demo_sg"
  description = "Allow ssh inbound traffic"

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh-port"
  }
}