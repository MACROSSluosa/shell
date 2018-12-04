#!/bin/bash
### 查找目录下所有今天的大于1M的文件
#find . -mtime 0 -type f -size +1000k > nownew
find . -type f -size +1000k > nownew
##找出差异文件
#diff  nownew  okftp | awk '{print $2}' > nowftp
####每行读取数据
filename='./nownew' #设置目录以及文件，
#fileprepare='./prepared'
ftpsend()
{
FTPLOG=./ftplogfile #def the log to grasp the succession for ftp 
ftp -inv <<! > $FTPLOG
open 172.16.139.33
user ftptest 1234qwer 
cd $directoryname
lcd $directoryname
put $filename001
close
quit
!
FTP_SUCCESS_MSG="226 Transfer complete"
if  fgrep "$FTP_SUCCESS_MSG" $FTPLOG ;then
   
		echo "ftp ok ${arr[0]}" >> okftp

else
   		echo "error ${arr[0]}" >> errorftp
fi

}

#OLD_IFS="$IFS" #备份IFS
#IFS="/"#设置自定义分割符号，空格为默认
i=0 #设置循环次数检查;当前发送文件个数
if [ -f ${filename} ];then
   while read line
   do
     arr=($line) #每一行的所有内容以空格为分割标记分成数组
	#echo ${arr[0]}
	# grep ${arr[0]} ./okftp
 	string=${arr[0]}
	directoryname=${string:0:8}
	filename001=${string:9}

 if [ ${arr[0]} ];then ##除去空字符串的第一行
		if [ `grep  ${arr[0]}  ./okftp` ];then
			echo "${arr[0]} 文件已经传送"
		else
			echo "${arr[0]} 文件未传送，即将传送"
			 ftpsend
		fi

	#echo ${arr[0]}
	fi
	#echo ${#arr[@]} #显示数组长度，每一行被分成了多少个数组
	i=$((i+1))

   done < ${filename}
fi
echo “本次文件传送回合总计操作文件个数为” $i 
