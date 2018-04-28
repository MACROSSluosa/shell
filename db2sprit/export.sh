#!/usr/bin/bash
db2 connect to XLCARDDB
list="
xlinst.chargejournal
xlinst.carddic
xlinst.RBAC_GROUP
xlinst.consumejournal
xlinst.PREACCOUNTCARDDIC
xlinst.PREACCOUNTDIC
xlinst.ACCOUNTDIC
xlinst.ACCOUNTJOURNAL
xlinst.preACCOUNTJOURNAL
xlinst.OPER_CARD_ALTER
xlinst.PAYJOURNAL
xlinst.DIC_CARDTYPE
"

for one in $list
    do
        db2 -v "export to /home/db2inst1/export/$one.sql  of del  select * from $one with ur">>export.log

        if [ $? -ne 0 ];then
            echo "error table:$one">>error.log 
        fi
    done


