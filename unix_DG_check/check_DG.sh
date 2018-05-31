#!B
#@DGlog.sql
#EOF
source /home/oracle/.bash_profile
sqlplus system/oracle@//10.180.222.100/hlwzfdb<<EOF
@DGlog.sql
EOF



sqlplus system/oracle@//10.180.24.18/hlwzfdbbak<<EOF
@DGbaklog.sql
EOF
a=$(sed -n '4p' /home/oracle/sql_script/DG.log | tr -d ' ')
b=$(sed -n '4p' /home/oracle/sql_script/DGbak.log | tr -d ' ')
echo $a
echo $b
echo -n $((a-b))>/tmp/DG_zabbix.log

if [ $a -ne $b ]; then
	echo " ERROR-db-DG"
	#let "c=$a-$b"
	#c=`expr $a -$b`
	c=$((a-b))
	if [ $c -eq 1 ];then
        echo "hlwzfdb_DG is baking"
        	curl 'http://10.180.4.230:8000/sending/?msg=互联网支付数据库灾备数据同步中:生产'$a'灾备'$b'&at=15953192216'
        elif [ $a -ne $b ]; then
	 	curl 'http://10.180.4.230:8000/sending/?msg=互联网支付数据库灾备同步异常&at=15953192216'
	fi
elif [ $a -eq $b ]; then
	#curl 'http://10.180.4.230:8000/sending/?msg=互联网支付数据库灾备数据同步正常，日志已经追平&at=15953192216'
	echo "hlwzfdb_DG is ok"
	echo "当前时间$date 日志追平"
		
fi
