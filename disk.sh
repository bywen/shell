#!/bin/bash
#每天生成一个磁盘使用情况的到文本中

date=`date +%Y%m%d`
data=/data/disk

if [ ! -d $data ]
then
   mkdir $data
fi

df -h >> /data/disk/$date.txt
