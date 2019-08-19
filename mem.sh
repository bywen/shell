#!/bin/bash
#计算内存使用总和

sum=0
mem=`ps aux |awk '{print $6}'|grep -v 'RSS'`

for n in $mem
do
    sum=$[$n+$sum]
done
echo $sum
