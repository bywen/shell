#!/bin/bash

for name in `cat /usr/local/sbin/nginxConf/name.txt`
do
  for dns in `cat /usr/local/sbin/nginxConf/dns.txt`
  do
    newconf="$name.$dns.conf"
    newname="$name.$dns"
    newpath="server_name $newname;"
    cp /usr/local/sbin/nginxConf/demo.conf /usr/local/nginx/conf/vhost/$newconf
     sed -i "3s@.*@        $newpath@" /usr/local/nginx/conf/vhost/$newconf
  done
done
/usr/local/nginx/sbin/nginx -t
