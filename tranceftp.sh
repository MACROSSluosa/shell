#!/bin/bash
### 查找目录下所有今天的大于1M的文件
find . -mtime 0 -type f -size +1000k > nownew
#find . -type f -size +1000k > nownew
##找出差异文件
#diff  nownew  okftp | awk '{print $2}' > nowftp
####每行读取数据
filename='./nownew' #设置目录以及文件，
#fileprepare='./prepared'
ftpsend()
{
ftp -n <<EOF
open 192.168.1.122
user ftp 1234qwer
put ${arr[0]}
EOF
#return 1
echo ${arr[0]} >> okftp
}

#OLD_IFS="$IFS" #备份IFS
#IFS=" "#设置自定义分割符号，空格为默认
i=0 #设置循环次数检查;当前发送文件个数
if [ -f ${filename} ];then
   while read line
   do
     arr=($line) #每一行的所有内容以空格为分割标记分成数组
	#echo ${arr[0]}
	# grep ${arr[0]} ./okftp

 if [ ${arr[0]} ];then ##除去空字符串的第一行
		if [ `grep  ${arr[0]}  ./okftp` ];then
			echo "${arr[0]} 文件已经传送"
		 else
			echo "${arr[0]} do not ftp! now it will be ftpd"
			 ftpsend
		fi

	#echo ${arr[0]}
	fi
	#echo ${#arr[@]} #显示数组长度，每一行被分成了多少个数组
	i=$((i+1))

   done < ${filename}
fi
echo $i
