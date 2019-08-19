#!/bin/bash
#统计1.txt文件里面一段话字母数小于6的单词有多少个

n=0
for i in `cat 1.txt`
do 
  num=`echo $i|wc -c`
  if [ $num -lt 7 ]
  then
     n=$[ $n + 1 ]
  fi
done
echo $n
