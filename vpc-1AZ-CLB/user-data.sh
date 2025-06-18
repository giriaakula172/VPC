#!/bin/bash 
sudo su 
yum install java-1.8.0* -y 
yum install httpd -y 
yum update -y 
echo "<H1>Hello-Priya</H1>" > /var/www/html/index.html 
systemctl enable httpd 
systemctl start httpd
