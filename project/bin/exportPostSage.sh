#!/bin/bash

cat $1 | awk -F ';' '{print $14}' | sort | uniq | grep 2[0-9][0-9][0-9] | while read FACTUREID; do
    php symfony facture:setexported $FACTUREID;
done

cat $1 >> web/export/bi/export_bi_factures.csv
