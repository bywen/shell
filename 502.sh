#!/bin/bash
#网站出现502,就重启php服务

while :
do
num=`tail -n 30 /data/nginx/riven.work_access.log|awk '{print $9}'|grep -c "502"
n=5
if [ $num > $n ]
then
   /etc/init.d/php restart 2>>/dev/null
   echo "502频发，重启php服务"
   sleep 50
fi
sleep 10
done
