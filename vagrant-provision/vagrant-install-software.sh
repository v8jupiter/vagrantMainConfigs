#!/bin/bash
#

echo "[Info] Install apache2"
sudo yum -y install httpd

echo "[Info] Install nano"
sudo yum -y install nano

echo "[Info] Install apache_mod_ssl"
sudo yum -y install mod_ssl

echo "[Info] Install php5"
sudo yum -y install php

echo "[Info] Install php-mysql"
sudo yum -y install php-mysql

echo "[Info] Install mysql-client"
sudo yum -y install mysql

echo "[Info] Install vim"
sudo yum -y install vim

echo "[Info] Install wget"
sudo yum -y install wget

echo "[Info] install php-devel"
sudo yum -y install php-devel

echo "[Info] install php-pear"
sudo yum -y install php-pear

echo "[Info] install gcc and other for build xdebug"
sudo yum -y install gcc gcc-c++ autoconf automake
