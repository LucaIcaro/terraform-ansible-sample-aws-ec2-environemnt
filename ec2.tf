
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
    self = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = aws_vpc.main.id
}

resource "aws_instance" "clusterB" {
  count = 3

  ami           = "ami-08cd358d745620807"
  instance_type = "t3.medium"
  subnet_id     = aws_subnet.main[count.index].id
  associate_public_ip_address = true

  security_groups = [aws_security_group.allow_ssh.id]

  key_name = "ansible"

  tags = {
    Name = "clusterB-${count.index + 1}"
    role = "clusterB"
    env = "dev"
    count = "${count.index + 1}"
  }
}

resource "aws_instance" "clusterA" {
  count = 3

  ami           = "ami-08cd358d745620807"
  instance_type = "t3.medium"
  subnet_id     = aws_subnet.main[count.index].id
  associate_public_ip_address = true

  security_groups = [aws_security_group.allow_ssh.id]

  key_name = "ansible"

  tags = {
    Name = "clusterA-${count.index + 1}"
    role = "clusterA"
    env = "dev"
    count = "${count.index + 1}"
  }
}
