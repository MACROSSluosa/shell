#!/usr/bin/bash
db2 connect to XLCARDDB
list="
xlinst.chargejournal.ixf
xlinst.carddic.ixf
xlinst.RBAC_GROUP.ixf
xlinst.consumejournal.ixf
xlinst.PREACCOUNTCARDDIC.ixf
xlinst.PREACCOUNTDIC.ixf
xlinst.ACCOUNTDIC.ixf
xlinst.ACCOUNTJOURNAL.ixf
xlinst.preACCOUNTJOURNAL.ixf
xlinst.OPER_CARD_ALTER.ixf
xlinst.PAYJOURNAL.ixf
xlinst.DIC_CARDTYPE.ixf
"

for one in $list
    do
        db2 -v "load from  /home/db2inst1/export/$one.ixf  of ixf  replace into $one">>replace.log

        if [ $? -ne 0 ];then
            echo "error table:$one">>error.log 
        fi
    done
