#!/bin/bash


''' EC2 bootstrap script '''
#!/bin/bash
yum update -y
yum install -y httpd24 git php56
service httpd start
chkconfig httpd on
cd /var/www/html
echo "<?php phpinfo();?>" > test.php
git clone https://github.com/acloudguru/dynamodb



''' Install AWS SDK for PHP v3 '''
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'e5325b19b381bfd88ce90a5ddb7823406b2a38cff6bb704b0acc289a09c8128d4a8ce2bbafcd1fcbdc38666422fe2806') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
php -d memory_limit=-1 composer.phar require aws/aws-sdk-php


''' Incase Memory issues on EC2 '''
/bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1024
/sbin/mkswap /var/swap.1
/sbin/swapon /var/swap.1



''' EC2 to invoke DynamoDB '''
aws dynamodb get-item --table-name {tablename} --region us-east-1 --key '{"Id":{"N":"205"}}' #query
