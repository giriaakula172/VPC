resource "aws_instance" "private_instance" {
  subnet_id              = aws_subnet.private_subnet.id
  ami                    = "ami-0038df39db13a87e2"
  key_name               = "login"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.security_group_httpd.id}"]
  user_data              = file("/opt/VPC/vpc-1AZ-LB/user-data.sh")
  tags = {
    Name = "Private-Instance"
  }
}
