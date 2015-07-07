#!/bin/bash
#

echo "[Info] Configuring apache2 host"
unlink /etc/httpd/conf/httpd.conf
cp /vagrant/vagrant-provision/templates/httpd.conf /etc/httpd/conf/httpd.conf

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
service httpd restart

echo "[Info] Update Iptables"
sudo iptables -I INPUT -i eth0 -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -I INPUT -i eth0 -p tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo service iptables save