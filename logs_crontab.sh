#!/bin/bash
#* * * * * /bin/bash /usr/local/sbin/logs_crontab.sh > /dev/null 2>&1
n=`ps aux |grep logs_clean.sh |wc -l`
if [ $n -lt 2 ]
then
   /usr/bin/bash /usr/local/sbin/logs_clean.sh &
fi
exit
