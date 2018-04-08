#!/bin/bash
filename='./portok'
OLD_IFS="$IFS"
IFS=" "

if [ -f ${filename} ];then
	while read line
	do
		arr=($line)
		ping -c2 ${arr[0]} >>/dev/null
		#ping -c2 $(echo $line | awk '{print $1}') >>/dev/null
		if [ $? -eq 0 ];then
		 
			echo "$line"
			nc -w 5 -z  $line >>log
			if [ $? -ne 0  ];then
				echo "$line port is bad">>loge	 
			fi 
			#nc -z $(echo $line | awk '{print $1}')  $(echo $line | awk '{print $2}') >>log 2>>log
		else  
			echo "$line can not ping">>log 
		
		fi

	done < ${filename}

fi


