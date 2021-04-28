#!/bin/bash
#这是一个限制日志大小的脚本，bywen
data_log=/data/square/storage/logs/
while :
do
  f_size=`/usr/bin/du -sm $data_log  |awk -F ' ' '{print $1}'`

  if [ $f_size -ge 5 ]
    then
      /usr/bin/find $data_log -type f -mtime +5 -name "*.log" -exec rm -f {} \;
      /usr/bin/find $data_log -type d -mtime +5 -name "202*" -exec rm -rf {} \;
      /usr/bin/find $data_log -type f -name "*.log" -exec cp /dev/null {} \;
    # /usr/bin/find $data_log -size +1M -type f -name "*.log" -exec cp /dev/null {} \;
     
  fi
  sleep 10
done

