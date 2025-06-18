resource "aws_security_group" "security_group_lb" {
  name        = "Load-Balancer-Security-Group"
  description = "security group for load balancer"
  vpc_id      = aws_vpc.devops_vpc.id

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
    Name = "CLB-SG"
  }
}
