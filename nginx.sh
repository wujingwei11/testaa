#!/bin/bash
cd /root/lnmp_soft/
tar -xf nginx-1.12.2.tar.gz

cd nginx-1.12.2/
yum -y install gcc pcre-devel openssl-devel
useradd -s /sbin/nologin nginx
./configure --user=nginx --group=nginx --with-http_ssl_module --with-http_stub_status_module

make && make install

yum -y install mariadb mariadb-server mariadb-devel
yum -y install php php-ftp php-mysql
systemctl start mariadb
systemctl start php-fpm
sed -i '65,71s/#//' /usr/local/nginx/conf/nginx.conf
sed -i 's/SCRAPT_FILENAME//' /usr/local/nginx/conf/nginx.conf
sed -i 's/fastcgi_params/fastcgi.conf/' /usr/local/nginx/conf/nginx.conf
/usr/local/nginx/sbin/nginx 

~                             
