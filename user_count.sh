#!/bin/bash

#统计系统里有多少个普通用户

#user=`cat /etc/passwd |awk -F ':' '{print $3}'`
#n=0
#for i in $user;do
#    if [ $i -ge 1000 ];then
#        n=$[$n+1]
#    fi
#done
#echo $n

#简化版：
n=`awk -F ':' '$3>=1000' /etc/passwd |wc -l`

if [ $n -gt 0 ];then
    echo "普通用户有：$n"
else
    echo "没有普通用户"
fi


