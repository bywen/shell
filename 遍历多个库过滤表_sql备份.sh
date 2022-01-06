#!/bin/bash
user="DBbackup"
passwd="test"
dump="/usr/local/mysql/bin/mysqldump"
week=`date +%w`
date=`date +%Y%m%d`
dir="/backup/db_sql"
for dbname in `cat /usr/local/sbin/db.txt`
do
  #过滤表 cnarea_2018
  if [ $dbname == "industrial_park" ]
  then
	$dump -u$user -p$passwd -h localhost --routines --events --triggers --single-transaction --flush-logs --databases $dbname --ignore-table=industrial_park.cnarea_2018 | gzip > $dir/$dbname-$date.sql.gz
  else
	$dump -u$user -p$passwd -h localhost --routines --events --triggers --single-transaction --flush-logs --databases $dbname | gzip > $dir/$dbname-$date.sql.gz
  fi
done

/usr/bin/tar zcfP /backup/send_file/park-tw_$week.tar.gz -C $dir .
/usr/bin/rm -f $dir/*
/usr/bin/rsync -arvz /backup/send_file/park-tw_$week.tar.gz wen@113.105.190.78::data/tw_mysql_backup/park-tw_$date.tar.gz --password-file=/etc/rsync.password

exit
