provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "demo-instance" {
  ami = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  key_name = "first_instance"
  for_each = toset(["Jenkins-master", "Jenkins-slave", "Ansible"])
   tags = {
     Name = "${each.key}"
   }
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