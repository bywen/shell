#!/bin/bash

#nginx日志分割
logdir=/usr/local/nginx/logs
prefix=`date -d "-1 day" +%y%m%d`

#for f in ``
#清除7天以前的lavaral log日志
find /data/ -type f -mtime +7 -name "*.log" -exec rm -f {} \;
find /data/square/storage/logs/ -type d -mtime +5 -name "2021*" -exec rm -rf {} \;

