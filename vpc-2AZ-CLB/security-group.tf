resource "aws_security_group" "security_group_httpd" {

  vpc_id      = aws_vpc.devops_vpc.id
  name        = "httpd-security-group"
  description = "security group for httpd"

  #SSH Inbound Rule 
  ingress {
    description = "SSH Protocol"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #HTTP Inbound Rule 
  ingress {
    description = "HTTP Protocol"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #All Traffic 
  egress {
    description = "Allows All Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "HTTPD-SG"
  }
}
