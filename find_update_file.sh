#!/bin/bash
# 查找一个目录里的文件是否有更新，如果有，将新文件的列表输入到一个日志里

d=`date -d "-5 min" +%F-%H:%M`
data=/test/

find $data -type f -mmin -5 >> /tmp/newfile.txt

n=`cat /tmp/newfile.txt |wc -l`
if [ $n -gt 0 ];then
    mv /tmp/newfile.txt /tmp/$d.txt
fi
