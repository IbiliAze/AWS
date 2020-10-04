#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "hello cloud gurus $(hostname -f)" > /var/www/html/index.html
echo "healthhh" > /var/www/html/health.html
