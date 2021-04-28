#!/bin/bash
user="backup"
passwd="17Dgap@Aw"
dump="/usr/local/mysql/bin/mysqldump"
dir="/backup/db_sql/"
datetype=`date +%w`
for dbname in `cat /usr/local/sbin/db.txt`
do
	$dump -u$user -p$passwd --routines --events --triggers --single-transaction --flush-logs --databases $dbname | gzip > $dir/$dbname-$datetype.sql.gz
done

cd $dir
tar zcf /backup/send_file/zxz-$datetype.tar.gz /backup/db_sql/*
/usr/bin/rsync -arvz /backup/send_file/zxz-$datetype.tar.gz wen@113.105.190.78::data/backup_mysql_zxz/ --password-file=/etc/rsync.password     
exit
