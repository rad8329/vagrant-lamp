#!/bin/bash

root_profile="/root/.profile"
apache_config_file="/etc/apache2/apache2.conf"
php_config_file="/etc/php5/apache2/php.ini"
xdebug_config_file="/etc/php5/mods-available/xdebug.ini"
mysql_config_file="/etc/mysql/my.cnf"
redis_config_file="/etc/redis/redis.conf"
mongo_config_file="/etc/mongodb.conf"

# To prevent warnings like "stdin: is not a tty"
sed -i "s/^mesg n$/tty -s \&\& mesg n/g" ${root_profile}

# Update the server
apt-get update
apt-get -y upgrade

if [[ -e /var/lock/vagrant-provision ]]; then
    exit;
fi

################################################################################
# Everything below this line should only need to be done once
# To re-run full provisioning, delete /var/lock/vagrant-provision and run
#
#    $ vagrant provision
#
# From the host machine
################################################################################

IPADDR=$(/sbin/ifconfig eth0 | awk '/inet / { print $2 }' | sed 's/addr://')
sed -i "s/^${IPADDR}.*//" /etc/hosts
echo $IPADDR ubuntu.localhost >> /etc/hosts			# Just to quiet down some error messages

# Install basic tools
apt-get -y install build-essential binutils-doc git

# Install Redis Server [For caching several apps]
apt-get -y install redis-server

sed -i "s/bind 127.0.0.1/bind 0.0.0.0/g" ${redis_config_file}

# Install Mongo Server
apt-get -y install mongodb-server
sed -i "s/bind_ip = 127.0.0.1/bind_ip = 0.0.0.0/g" ${mongo_config_file}

# Install Apache
echo "Installing Apache2"
apt-get -y install apache2
a2enmod rewrite
sed -i "s/AllowOverride None/AllowOverride All/g" ${apache_config_file}

# Install PHP
echo "Installing PHP5"
apt-get -y install php5 php5-curl php5-mysql php5-sqlite php5-xdebug php5-mcrypt php5-imagick php5-mongo
php5enmod mcrypt


# Install composer
echo "Installing Composer"
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin
mv /usr/bin/composer.phar /usr/bin/composer

sed -i "s/display_startup_errors = Off/display_startup_errors = On/g" ${php_config_file}
sed -i "s/display_errors = Off/display_errors = On/g" ${php_config_file}
sed -i "s/short_open_tag = Off/short_open_tag = On/g" ${php_config_file}
sed -i "s/;date.timezone =/date.timezone = \"America\/Bogota\"/g" ${php_config_file}

cat << EOF > ${xdebug_config_file}
zend_extension=xdebug.so
xdebug.remote_enable=1
xdebug.remote_connect_back=1
xdebug.remote_port=9000
xdebug.remote_host=10.0.2.2
EOF

# Install MySQL
echo "mysql-server mysql-server/root_password password root" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password root" | sudo debconf-set-selections
apt-get -y install mysql-client mysql-server

sed -i "s/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" ${mysql_config_file}

# Allow root access from any host
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION" | mysql -u root --password=root
echo "GRANT PROXY ON ''@'' TO 'root'@'%' WITH GRANT OPTION" | mysql -u root --password=root

# Restart Services
service apache2 restart
service mysql restart
service redis-server restart

touch /var/lock/vagrant-provision
