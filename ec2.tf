resource "aws_instance" "server_a" {
  ami                         = "ami-003c463c8207b4dfa"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_a.id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.public_sg.id]
  key_name                    = "my-server-keys"
  user_data                   = file("scripts/setup-nginx.sh")
  tags = {
    Name = "server-a"
  }
}

resource "aws_instance" "server_b" {
  ami                         = "ami-003c463c8207b4dfa"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_b.id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.public_sg.id]
  key_name                    = "my-server-keys"
  user_data                   = file("scripts/setup-nginx.sh")
  tags = {
    Name = "server-b"
  }
}


