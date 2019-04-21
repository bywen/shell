#!/bin/bash
#随机打印100以的数字10次。
for i in {1..10}
do
 echo $[$RANDOM%100]
done
