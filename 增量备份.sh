#!/bin/bash
user="DBbackup"
passwd="30feBWvd+"
dump="/usr/bin/innobackupex"
d=`date +%F`
#增量备份前先进行全量备份
$dump --host=127.0.0.1 --user=$user --password=$passwd --no-timestamp  --socket=/tmp/mysql.sock  --incremental-basedir=/backup/full_backup --incremental /backup/increl_$d

#判断磁盘大小
result=`df -h | sed -n 6p | awk '{print int($5)}'`
if [ $result -gt 75 ]
then
   find /backup/ -type d -mtime +10 -name increl* -exec mv {} /tmp \;
fi

exit
