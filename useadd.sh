#!/bin/bash
#批量创建用户

for i in `seq 1 3`

do
  useradd user_$i
  pw=`mkpasswd`
  echo $pw|passwd --stdin user_$i
  echo "user_$i : $pw" >> /root/user.txt

done
