#!/bin/bash
#

echo "[Info] Configuring apache2 host"
unlink /etc/httpd/conf/httpd.conf
cp /vagrant/vagrant-provision/templates/httpd.conf /etc/httpd/conf/httpd.conf
mkdir /etc/httpd/virtualhosts
mkdir /etc/httpd/ssl
cp /vagrant/vagrant-provision/ssl_certs/* /etc/httpd/ssl
chkconfig httpd on

echo "[info] build xdebug"
cd /temp
wget -c http://xdebug.org/files/xdebug-2.2.1.tgz
tar -xzf xdebug-2.2.1.tgz
cd xdebug-2.2.1
phpize
sudo ./configure --enable-xdebug
sudo make
sudo make install

echo "[Info] Configuring php"
unlink /etc/php.ini
cp /vagrant/vagrant-provision/templates/php.ini /etc/php.ini
rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt
rpm -Uhv http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum -y install php-mcrypt
service httpd restart

echo "[Info] Update Iptables"
sudo iptables -F
sudo iptables-save > /etc/sysconfig/iptables