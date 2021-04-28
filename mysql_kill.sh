#!/bin/bash

for i in `mysql -h192.168.40.246 -utest -ptest2020 -Bse "show processlist" | awk '{print $1}'`
do
  mysql -h192.168.40.246 -utest -ptest2020 -e "kill $i"
done
