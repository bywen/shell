#!/usr/bin/env python
# -*- coding:utf8 -*-
import os
import time
import datetime

DB_HOST = 'localhost'
DB_USER = 'root'
DB_USER_PASSWD = 'Wr2020.$'
DB_NAME = '/usr/local/src/mysql/dbnames.txt'
BACKUP_PATH = '/data/dbbackup/mysql/'
DATETIME = time.strftime('%Y%m%d-%H%M%S')
TODAYBACKUPPATH = BACKUP_PATH + DATETIME
print("创建备份文件夹 %s"%BACKUP_PATH)

if not os.path.exists(TODAYBACKUPPATH):
    os.makedirs(TODAYBACKUPPATH)
    print("检查 %s有没有写数据库名称！！"%DB_NAME)

def run_backup():
    in_file = open(DB_NAME,"r")
    for dbname in in_file.readlines():
        dbname = dbname.strip()
        dumpcmd = "mysqldump -u" +DB_USER + " -p"+DB_USER_PASSWD+" " +dbname+" > "+TODAYBACKUPPATH +"/"+dbname+".sql"
        print("开始备份数据库 %s" %dbname)
        print(dumpcmd)
        os.system(dumpcmd)
        file1.close()

def run_tar():
    compress_file = TODAYBACKUPPATH + ".tar.gz"
    compress_cmd = "tar -czvf " +compress_file+" "+DATETIME
    os.chdir(BACKUP_PATH)
    os.system("ls")
    os.system(compress_cmd)
    print("打包数据!")
    remove_cmd = "rm -rf "+TODAYBACKUPPATH
    os.system(remove_cmd)

if os.path.exists(DB_NAME):
    file1 = open(DB_NAME)
    print("备份状态 "+DB_NAME)
    run_backup()
    run_tar()
    print("backup success!")
else:
    print("database file not found..")
    exit()
