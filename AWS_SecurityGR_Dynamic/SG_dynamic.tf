provider "aws" {
    region = "eu-central-1"
}



resource "aws_security_group" "dynamic_web_server" {
  name        = "WebServer Security Group"
  description = "SG for WebServer"

  dynamic "ingress"{
    for_each = [80,443, 8080]
    content{
      description      = "web port"
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  }
  ingress{
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["185.8.183.0/24"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Dynamic_WebServer_SG"
  }
}