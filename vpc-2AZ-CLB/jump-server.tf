resource "aws_instance" "jump_server_1a" {
  subnet_id              = aws_subnet.public_subnet_1a.id
  ami                    = "ami-0038df39db13a87e2"
  instance_type          = "t2.micro"
  key_name               = "login"
  vpc_security_group_ids = ["${aws_security_group.security_group_httpd.id}"]
  tags = {
    Name = "Jump-Server-1a"
  }
}
