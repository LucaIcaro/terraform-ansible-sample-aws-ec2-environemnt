provider "aws" {
  region = "eu-west-2"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "main" {
  count = 3

  cidr_block = "10.0.${count.index + 1}.0/24"
  vpc_id     = aws_vpc.main.id

  tags = {
    Name = "main-subnet-${count.index + 1}"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 27017
    to_port     = 27019
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = aws_vpc.main.id
}

resource "aws_instance" "mongoc" {
  count = 3

  ami           = "ami-08cd358d745620807"
  instance_type = "t3.medium"
  subnet_id     = aws_subnet.main[count.index].id

  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = "mongoc-${count.index + 1}"
  }
}

resource "aws_instance" "mongod" {
  count = 3

  ami           = "ami-08cd358d745620807"
  instance_type = "t3.medium"
  subnet_id     = aws_subnet.main[count.index].id

  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = "mongod-${count.index + 1}"
  }
}
