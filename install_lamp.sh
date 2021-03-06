#!/bin/bash
until apt-get -y update
do
  echo "Try again"
  sleep 5
done

# set up a silent install of MySQL
dbpass=complish

export DEBIAN_FRONTEND=noninteractive
echo mysql-server-5.6 mysql-server/root_password password $dbpass | debconf-set-selections
echo mysql-server-5.6 mysql-server/root_password_again password $dbpass | debconf-set-selections

# install the LAMP stack
until apt-get -y install apache2 mysql-server php5 php5-mysql phpMyAdmin
do
  echo "Try again"
  sleep 5
done
# write some PHP
echo \<center\>\<h1\>My Demo App\</h1\>\<br/\>\</center\> > /var/www/html/phpinfo.php
echo \<\?php phpinfo\(\)\; \?\> >> /var/www/html/phpinfo.php

# restart Apache
apachectl restart