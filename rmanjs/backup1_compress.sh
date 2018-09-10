connect target  /
run
{
allocate channel d1 type disk;
allocate channel d2 type disk;
allocate channel d3 type disk;
backup as compressed backupset incremental level 1 format '/dbbak/hlwzf_incr_%U' database include current controlfile;
delete noprompt obsolete;
sql 'alter system archive log current';
backup as compressed backupset  format '/dbbak/hlwzf_arch_incr_%U' archivelog all not backed up delete input;
crosscheck backup;
delete noprompt expired backup;
release channel d1;
release channel d2;
release channel d3;
}

