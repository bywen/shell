#!/bin/bash

fullData='/backup/mysql/fullBackup/'
incrementDate='/backup/mysql/incrementBackup/incre'
mysqld='/etc/init.d/mysqld'
inno='/usr/bin/innobackupex'
echo '备份还原'
$mysqld stop
rm -rf /tmp/mysql/*
mv /data/mysql/* /tmp/mysql/

echo '1、全量还原'
echo '2、增量还原'
echo '请输入'; read num
case $num in
    1)
      echo '全量还原开始'
      $inno --apply-log --redo-only --use-memory=2G $fullData
      $inno --copy-back $fullData
      chown -R mysql:mysql /data/mysql/
      $mysqld start
      echo 'full backup is done'
    ;;
    2)
      echo '增量文件只能还原一次，第二次还原需重新解压'
      echo '请输入增量包日期，例：20250414' 
      echo '请输入'; read numdate
      echo '增量还原开始...'
      $inno --apply-log --redo-only --use-memory=2G $fullData
      $inno --apply-log --redo-only $fullData --incremental-dir=$incrementDate$numdate
      $inno --copy-back $fullData
      chown -R mysql:mysql /data/mysql/
      $mysqld start
      echo 'increment backup is done'
    ;;
esac

