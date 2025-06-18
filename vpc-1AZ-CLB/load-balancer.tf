resource "aws_elb" "load_balancer" {

  name = "Classic-Load-Balancer"
  #vpc_id = aws_vpc.devops_vpc.id 	
  #availability_zones = "ap-south-1a"          ##availability_zones = "${var.azs}"
  subnets         = ["${aws_subnet.public_subnet.id}"]
  security_groups = ["${aws_security_group.security_group_lb.id}"]

  listener {
    lb_protocol       = "http"
    lb_port           = 80
    instance_protocol = "http"
    instance_port     = 80
  }

  health_check {
    target              = "HTTP:80/index.html"
    timeout             = 3
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  instances                   = ["${aws_instance.private_instance.id}"]
  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 300
  idle_timeout                = 100

  tags = {
    Name = "CLB"
  }
}

output "elb-dns-name" {
  value = "aws_elb.load_balancer.dns_name"
}
