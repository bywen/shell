#!/bin/bash

logfile=/data/nginx/riven.work_access.log
d1=`date -d "-1 minute" +%M:%H`
d2=`date +%M`
ipt=/sbin/iptables
ips=/tmp/ips.txt

echo $1
