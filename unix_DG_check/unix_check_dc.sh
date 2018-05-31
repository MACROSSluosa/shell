#!/bin/bash
source /home/oracle/.profile
/u02/app/oracle/product/11.2.0/db_1/bin/sqlplus system/oracle@//10.180.222.100/hlwzfdb<<EOF
@/home/oracle/DG_check/DGlog.sql
EOF

/u02/app/oracle/product/11.2.0/db_1/bin/sqlplus system/oracle@//10.180.24.18/hlwzfdbbak<<EOF
@/home/oracle/DG_check/DGlog.sql
EOF
a=$(sed -n '4p' /home/oracle/DG_check/DG.log | tr -d '')
b=$(sed -n '4p' /home/oracle/DG_check/DGbak.log | tr -d '')

#echo $a
#echo $b
echo -n $((a-b))>/tmp/DG_zabbix.log

