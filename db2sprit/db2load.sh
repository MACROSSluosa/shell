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
xlinst.OIL_CHARGECONSUM_FIRST
xlinst.OIL_CHARGECONSUM_RESULT
xlinst.OIL_CONSUM_MONTH
xlinst.OIL_CONSUMEJOURNAL_DETAIL
xlinst.OIL_DIC_GUEST_ATRR
xlinst.INVOICE_ADD
xlinst.INVOICE_ADD_TMP
xlinst.INVOICE_ADD_HMX
xlinst.INVOICE_ADD_HMX_TMP
xlinst.INVOICE_GUEST_ALL
xlinst.INVOICE_ALL_NEW_TMP
xlinst.ALTER_CHARGECONSUM
xlinst.PARAM_PURCHASE_SCOPE
xlinst.DIC_GUEST_INVOICE
xlinst.PARAM_PURCHASELIST_NOINVOICE
"

for one in $list
    do
        db2 -v "load from  /sdgs/import/$one.ixf  of ixf  replace into $one nonrecoverable ">>replace.log

        if [ $? -ne 0 ];then
            echo "error table:$one">>error.log
        fi
    done
