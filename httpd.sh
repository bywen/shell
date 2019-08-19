#!/bin/bash
#检查httpd的80端口是否开启


while :
do
 hd=`pgrep -l nginx |wc -l`
 mail=1004195613@qq.com
 st=`/etc/init.d/nginx start`
 if [ $hd -eq 0 ]
 then
     $st
     python mail.py $mail "httpd is down: $hd" "reload httpd"
 else
    echo "httpd process lines is:$hd"
    
 fi
sleep 3 
done


 
