#!/bin/bash
user="DBbackup"
passwd="30ffdadfb"
dump="/usr/local/mysql/bin/mysqldump"
week=`date +%w`
date=`date +%Y%m%d`
dir="/backup/db_sql/file"
chmod 755 $dir/*
rm -f $dir/*.sql.gz

for dbname in `cat /usr/local/sbin/db.txt`
do
  #过滤表 wr_sys_area
  if [ $dbname == "snacksv2" ]
  then
	$dump -u$user -p$passwd -h localhost --routines --events --triggers --single-transaction --flush-logs --databases $dbname --ignore-table=snacksv2.wr_sys_area | gzip > $dir/$dbname-$date.sql.gz
  else
	$dump -u$user -p$passwd -h localhost --routines --events --triggers --single-transaction --flush-logs --databases $dbname | gzip > $dir/$dbname-$date.sql.gz
  fi
done
/usr/bin/tar zcfP /backup/db_sql/snacks_$week.tar.gz -C $dir .

#传到内网服务器
/usr/bin/rsync -az /backup/db_sql/snacks_$week.tar.gz wen@11.131.13.31::data/snacks_backup/snacks_$date.tar.gz --password-file=/etc/rsync.password