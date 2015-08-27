#!/bin/bash
#

echo "[Info] Configuring apache2 host"
unlink /etc/httpd/conf/httpd.conf
cp /vagrant/vagrant-provision/templates/httpd.conf /etc/httpd/conf/httpd.conf
mkdir /etc/httpd/virtualhosts
mkdir /etc/httpd/ssl
cp /vagrant/vagrant-provision/ssl_certs/* /etc/httpd/ssl
unlink /etc/httpd/conf.d/ssl.conf
cp /vagrant/vagrant-provision/templates/ssl.conf /etc/httpd/conf.d/ssl.conf

chkconfig httpd on

echo "[Info] Configuring mysql"
unlink /etc/my.conf
cp /vagrant/vagrant-provision/templates/my.cnf /etc/my.conf
sudo service mysqld restart
chmod +x /vagrant/vagrant-provision/bin/mysql.sh
sh /vagrant/vagrant-provision/bin/mysql.sh
sudo service mysqld restart

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

echo "[Info] Update Iptables"
sudo iptables -F
sudo iptables-save > /etc/sysconfig/iptables

echo "[Info] Disable selinux"
sed -i 's/SELINUX=\(enforcing\|permissive\)/SELINUX=disabled/g' /etc/selinux/config
setenforce 0

service httpd restart