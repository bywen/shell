#!/bin/bash
user="DBbackup"
passwd="30feBWvd+"
dump="/usr/bin/innobackupex"
d=`date +%F`
#��������ǰ�Ƚ���ȫ������
$dump --host=127.0.0.1 --user=$user --password=$passwd --no-timestamp  --socket=/tmp/mysql.sock  --incremental-basedir=/backup/full_backup --incremental /backup/increl_$d

#�жϴ��̴�С
result=`df -h | sed -n 6p | awk '{print int($5)}'`
if [ $result -gt 75 ]
then
   find /backup/ -type d -mtime +10 -name increl* -exec mv {} /tmp \;
fi

exit
