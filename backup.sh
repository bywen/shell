#!/bin/bash
#备份数据库到本地，保存一个礼拜，备份到远程服务器，保存一个月

date=`date +%w`
date2=`date +%d`
pw=123
PATH=$PATH:/usr/local/mysql/bin
mysqldump -uroot -p$pw zabbix > /tmp/zabbix_$date.sql

if [ $? == 0 ] || [ -f zabbix_$date.sql ]
then
   echo "本地备份成功"
fi

cp /tmp/zabbix_$date.sql /tmp/zabbix_$date2.sql
scp /tmp/zabbix_$date2.sql root@47.112.35.244:/tmp/
if [ $? == 0 ]
then
   echo "远程备份成功！"
fi

