provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-08f3d892de259504d"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}