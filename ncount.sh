#!/bin/bash
#统计文件中每一行包函数字个数及整个文件出现数字个数

n=`wc -l 1.txt |awk '{print $1'}`
sum=0
for i in `seq 1 $n`;do
   line=`sed -n "$i"p 1.txt`
   n_n=`echo -n $line |sed "s/[^0-9]//g" |wc -L`
   echo "第 $i 行有 $n_n 数字"
   sum=$[$sum+$n_n]
done
echo "文件中总共有 $sum 数字"
