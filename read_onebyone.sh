#!/bin/bash

#-------put them into arry
filename='./textone' #设置目录以及文件，
OLD_IFS="$IFS" #备份IFS
IFS=" "#设置自定义分割符号，空格为默认
i=0 #设置行号
if [ -f ${filename} ];then
   while read line
   do
     arr=($line) #每一行的所有内容以空格为分割标记分成数组
     #echo ${arr[0]}_${arr[1]}_${arr[2]}_${arr[3]}_${arr[4]}_${arr[5]}_${i} #显示带行号的每一行分割的数组
     echo ${arr[@]} #访问整个数组
     echo ${#arr[@]} #显示数组长度，每一行被分成了多少个数组
     i=$((i+1))
   done < ${filename}
fi 
