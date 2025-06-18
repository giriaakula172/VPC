resource "aws_security_group_rule" "httpd_rule" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.security_group_lb.id
  security_group_id        = aws_security_group.security_group_httpd.id
}
