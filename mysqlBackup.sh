#!/bin/bash

echo '--用innobackupex增量备份--'
echo '请提前创建备份用户并给予相关权限！'
echo ' start ........'

##定义变量
user="backup"
passwd="yDF8&k6qj"
fullPath="/backup/mysql/fullBackup"
incPath="/backup/mysql/incrementBackup"
sendPath="/backup/send_file"
inno="/usr/bin/innobackupex"
ch="/usr/bin/chown"
tar="/usr/bin/tar"
date=`date +%Y%m%d`
datetype=`date +%w`
dateago=`date -d "3 days ago" +%Y%m%d`

#删除3天前的增量备份
rm -rf $incPath/incre$dateago

#判断全备文件夹是否为空,如果是空的执行全备,不是空的执行增量备
if [ -z "$(ls -A $fullPath)" ]
then
   echo '开始全量备份....'
   $inno --user=$user --password=$passwd --no-timestamp  --socket=/tmp/mysql.sock --stream=tar $fullPath |gzip -> $sendPath/fullDate$date.tar.gz
   tar -zxf $sendPath/fullDate$date.tar.gz  -C $fullPath
else
   echo '开始增量备份....'
   $inno --user=$user --password=$passwd --no-timestamp --socket=/tmp/mysql.sock  --incremental-basedir=$fullPath --incremental $incPath/incre$date
   echo '打包发送备份..'
   $tar zcf $sendPath/zxz_incre$datetype.tar.gz -C $incPath incre$date
   /usr/bin/rsync -arz $sendPath/zxz_incre$datetype.tar.gz wen@113.105.190.78::data/dbBackup/mysql/incrementBackup/zxz_incre$date.tar.gz --password-file=/etc/rsync.password
  

fi

exit
