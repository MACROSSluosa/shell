!/bin/ksh
DATE=`date +%Y-%m-%d`
export ORACLE_HOME=/u02/app/oracle/product/11.2.0/db_1
export ORACLE_BASE=/u02/app/oracle
export ORACLE_SID=hlwzfdb1
$ORACLE_HOME/bin/rman cmdfile /home/oracle/scripts/backup1_compress.sh log=/home/oracle/scripts/log_rman_backup1_$DATE
