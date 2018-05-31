spool DG.log
select  max(sequence#) from v$log;
spool OFF
