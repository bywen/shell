#!/bin/bash

num=`cat /data/nginx/riven.work_access.log |awk '{print $1}' |sort |uniq -c |sort -nr |awk '{print $1}'`

for i in $num
do
  if [ $i -gt 10 ]
  then
      echo $i
  fi

done 
