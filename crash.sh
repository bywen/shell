#!/bin/bash
#查一台机是否宕机，如果宕机发邮件至指定邮箱


ip=17.0.0.1
add=1004195613@qq.com
num=`ping -c 5 $ip |grep 'packet'|awk -F '%' '{print $1}'|awk '{print $NF}'`
echo $num

if [ $num -ge 50 ]
then
    python mail.py $add "sos" "computer $ip is down"
fi

