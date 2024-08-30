#!/bin/bash
yum -y update
yum -y install httpd

echo "<h2>WebServer </h2><br>Build by Terraform using External Script!"  >  /var/www/html/index.html
echo "<br>Hello World!!" >> /var/www/html/index.html

sudo service httpd start
chkconfig httpd on
