#!/bin/bash

databases=("contact" "new_zxz" "tars_order" "tars_pay" "wr_account" "wr_account_middleground" "user_service")

#恢复云数据库
today=`date +%Y%m%d`
data='/data/mysql'
mysqld='/etc/init.d/mysqld'
passwd='xxxx'
spath='/usr/local/src/dataMysql/sendfile'
dpath='/usr/local/src/dataMysql/dataSql'
ypath='/usr/local/src/dataMysql'
passwdB='xxxxxx'
dataPath='/usr/local/src/dataSql'

#远程服务器IP
ip='xxxxxx'

$mysqld stop

if [ $? -eq 0 ]; then
  echo '停用数据库成功'
 
  if [ -d "$data" ]; then
     echo '移除旧目录'
     mv $data /tmp/mysql$today
     
     echo '创建新目录'	
     mkdir $data
    
     echo '还原data'
     xbstream -x -C $data < $ypath/user$today.xb
     xtrabackup --decompress --target-dir=$data
     xtrabackup --prepare  --target-dir=/data/mysql 	
     
    if [ $? -eq 0 ];then
        mv $data/backup-my.cnf /tmp/
        cp /root/backup-my.cnf $data
        chown -R mysql:mysql $data
        $mysqld start
	echo '还原云数据成功了！'
     fi
   else
      echo '创建新目录'	
      mkdir $data
      
      echo '还原data'
      xbstream -x -C $data < $ypath/user$today.xb
      xtrabackup --decompress --target-dir=$data
      xtrabackup --prepare  --target-dir=/data/mysql 	
      
      if [ $? -eq 0 ];then
         mv $data/backup-my.cnf /tmp/
         cp /root/backup-my.cnf $data
         chown -R mysql:mysql $data
       
         $mysqld start
         echo '还原云数据成功了！'
       fi
  fi  
fi

#backup date
mysql -uroot -p$passwd -e 'update mysql.user set host='%' where user='root' and host='localhost';'

for d in ${databases[@]};do
 echo '备份数据库sql' $d
 mysqldump -uroot -p$passwd $d > $dpath/$d.sql
 echo $d '备份完成 backup end'
done

echo '打包...'
tar zcvf $spath/user$today.tar.gz -C $dpath .

#send file
echo '发送数据到服务器...'

#测试
#scp $spath/user$today.tar.gz root@192.168.40.247:/root/test/user/backupData
#线上
scp -P 4728 -i /root/user/zxz $spath/user$today.tar.gz root@$ip:/usr/local/src/dataSql
echo '发送完成!!!'



#创建数据库
for d in ${databases[@]};do
  echo '创建数据库' $d
  mysql -u root -p$passwdB-e "create database  $d charset=utf8"

  echo '还原数据库' $db
  mysql -u root -p$passwdB  $d < $dataPath/$d.sql

done
#还原sql
echo '创建用户名密码'
mysql -uroot -p$passwdB mysql -e "$(cat $dataPath/myUser.sql)"

echo 'done'
~           
