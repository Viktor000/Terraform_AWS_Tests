provider "aws" {
    region = "eu-central-1"
}

resource "aws_instance" "web_server"{
    count = 1
    ami = "ami-089b5384aac360007" # Amazon Linux
    instance_type = "t2.micro"
    tags = {
        Name = "web_server"
        Owner = "Victor"
        test = "22"
    }
    vpc_security_group_ids = [aws_security_group.web_server.id]
    user_data = templatefile("run.sh.tpl",{
      name="Victor",
      names = ["User1", "User2", "User3"]
    })
}


resource "aws_security_group" "web_server" {
  name        = "WebServer Security Group"
  description = "SG for WebServer"

  ingress {
    description      = "web port"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "secure web port"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "WebServer_SG"
  }
}