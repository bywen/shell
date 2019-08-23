#!/bin/bash

#列出用得最多的10个命令

sort /root/.bash_history |uniq -c |sort -nr |head
