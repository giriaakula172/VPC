resource "aws_instance" "private_instance_1a" {

  subnet_id              = aws_subnet.private_subnet_1a.id
  ami                    = "ami-0038df39db13a87e2"
  instance_type          = "t2.micro"
  key_name               = "login"
  vpc_security_group_ids = ["${aws_security_group.security_group_httpd.id}"]
  user_data              = file("/opt/VPC/vpc-2AZ-CLB/user-data.sh")
  tags = {
    Name = "private-instance-1a"
  }
}
