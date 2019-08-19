#!/bin/bash
#统计每个ip访问网站总量，并排出前10
count=`cat /data/nginx/riven.work_access.log |awk '{print $1}' |sort |uniq -c|sort -r|head`
echo '访问网站的ip总量前十为:' 
echo $count
