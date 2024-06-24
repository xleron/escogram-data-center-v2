resource "aws_instance" "server_a" {
  ami                         = "ami-003c463c8207b4dfa"
  instance_type               = "t3.medium"
  subnet_id                   = aws_subnet.public_a.id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.public_sg.id]
  key_name                    = "escogram"
  user_data                   = file("scripts/setup-nginx.sh")
  tags = {
    Name = "escogram-server-a"
  }
}

# resource "aws_instance" "server_b" {
#   ami                         = "ami-003c463c8207b4dfa"
#   instance_type               = "t3.medium"
#   subnet_id                   = aws_subnet.public_b.id
#   associate_public_ip_address = true
#   security_groups             = [aws_security_group.public_sg.id]
#   key_name                    = "escogram"
#   user_data                   = file("scripts/setup-nginx.sh")
#   tags = {
#     Name = "server-b"
#   }
# }


