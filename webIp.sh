#!/bin/bash
#根据WEB服务上的访问日志，把一些请求量高的ip给DROP掉并且每隔半小时把不再发起请或者请求量很小的ip解封。

d1=`date -d "-1 min" +%H:%M`
logfile=/root/test_logs/1.log
ip=/tmp/ip.txt
ipt=/sbin/iptables

block(){
    grep "$d1" $logfile |awk '{print $1}' |sort |uniq -c |sort -nr >> $ip
    for i in `awk '$1 > 100 {print $2}' $ip`
    do
      $ipt -I INPUT -p tcp --dport 80 -s $i -j REJECT
      echo "`date +%F--%T`$i" >> /tmp/badip.txt
    done        
}

unlock(){
   for u in `$ipt -nvL INPUT --line-numbers |grep '0.0.0.0/0' |awk '$2<10 {print $1}' |sort -nr`;do
   $ipt -D INPUT $u 
   done
   $ipt -Z

}

#每隔半小时执行
d2=`date +%M`
if [ $d2 == 00 ] || [ $d2 == 30 ];then
    unlock
    block
else
    block
fi

