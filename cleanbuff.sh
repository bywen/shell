#!/bin/bash
n=`free -h |grep Mem |awk '{print $4}' |awk -F . '{print $1}'`

if [ $n -lt 2 ]
then
  sync;sync;sync #写入硬盘，防止数据丢失 
  echo 1 > /proc/sys/vm/drop_caches  #清除page cache
  echo 2 > /proc/sys/vm/drop_caches  #清除回收slab分配器中的对象(包括目录项缓存和inode缓存)
  echo 3 > /proc/sys/vm/drop_caches  #清除pagecache和slab分配器中的缓存对象。
fi
exit
