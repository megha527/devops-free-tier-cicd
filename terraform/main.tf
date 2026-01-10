terraform {
  backend "s3" {
    bucket = "my-terraform-state-free-tier-12345"
    key    = "cicd/terraform.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = "ap-south-1"
}

# Security Group
resource "aws_security_group" "web_sg" {
  name = "free-tier-web-sg"

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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "app_server" {
  ami             = "ami-02b8269d5e85954ef"
  instance_type   = "t2.micro"
  key_name        = "jenkins-key"
  security_groups = [aws_security_group.web_sg.name]

  tags = {
    Name = "free-tier-app-server"
  }
}
