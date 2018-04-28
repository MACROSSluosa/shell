--获得用户下所有建表语句
set pagesize 0
set long 90000
set feedback off
set echo off 
spool get_schemaindex.sql
connect ditest01/ditest01
SELECT DBMS_METADATA.GET_DDL('TABLE',u.index_name) FROM USER_TABLES u;
spool off;

