provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0ac80df6eff0e70b5"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.mysg1.id]
  key_name = aws_key_pair.rajankpUbuntu.key_name

  user_data = <<-EOF
      #!/bin/bash
      echo "Rathinam Trainers" > index.html
      nohup busybox httpd -f -p 8080 &
      EOF
  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_security_group" "mysg1" {
  name  = "mysg1"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
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

resource "aws_key_pair" "rajankpUbuntu" {
  key_name   = "rajankpUbuntu"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC5wPvs4sd5BqqQ9/X/vIbRQ0JejmdmfqX95WoDextypbRveuy7vhQrKQ8YRJwHU0G+/cX1BWfd6d9C/uepjuX/q/26tEuaCH+c8Ne5lRDSFlhDHlHH53sQG064pwTEPPryfyPvZGD1hgU12H6QgsVNFuofEFUYOmYz6JFE8TG6boppX56XcuIdDmf71zTli5M0Z40LR20Pc/95iCn1HDGi7nbfPbXCSvr1cLIK7cZznTjcSETdnLbXPZyrXNuQ5R3c+vo3K0epfkUp6ek3+uRBXVemwsHdylh5G+gX4NxEAToWEnzDVebBn/pxsyQUzxxwAwgXlCdCAT6hZQL1ZHSJikhdNzIAboMRJ9N+8zCMlsZ/hGB+OCt0Lb5W9MvApEj/ToC+oZGdyTV51LwHscIdxXPAHVX2jj2eoRqqS9nADan9Lfcy1WrqeSyydqSCX55P87aHq3y68piTpFYk7xQ4ixq6zv+QvyjHQJDcjropgj0ZU7KYmDNMP/i5tjwDR70= rajan@ubuntu"
}
