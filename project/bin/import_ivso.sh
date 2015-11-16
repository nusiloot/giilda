#!/bin/bash

. bin/config.inc

REMOTE_DATA=$1

SYMFODIR=$(pwd);
DATA_DIR=$TMP/data_ivso_csv

if test "$1"; then
    echo "Récupération de l'archive"
    scp $1 $TMP/data_ivso.zip
    
    echo "Désarchivage"
    rm -rf $TMP/data_ivso_origin
    mkdir $TMP/data_ivso_origin
    cd $TMP/data_ivso_origin
    unzip $TMP/data_ivso.zip

    rm $TMP/data_ivso.zip

    rename 's/^Table //' *
    rename 's/ /_/' *
    rename 's/des_//' *

    cd $SYMFODIR

    echo "Conversion des fichiers en csv"
    
    rm -rf $DATA_DIR
    mkdir -p $DATA_DIR

    ls $TMP/data_ivso_origin | while read ligne  
    do
        CSVFILENAME=$(echo $ligne | sed 's/\.xlsx/\.csv/')
        echo $DATA_DIR/$CSVFILENAME
        xlsx2csv -d ";" $TMP/data_ivso_origin/$ligne > $DATA_DIR/$CSVFILENAME
    done

    rm -rf $TMP/data_ivso_origin
fi

echo "Import des contacts"

#cat $DATA_DIR/producteurs_produits.csv | awk -F ';' '{ print $2 ";VITICULTEUR;" $4 ";;ACTIF;;" $13 ";;;" $5 ";" $6 ";" $7 ";;" $8 ";" $10 ";;" $17 ";" $14 ";;" $15 ";" $16 ";;" }' > $DATA_DIR/societes.csv

cat $DATA_DIR/producteurs_produits.csv | awk -F ";" '{ print $2 ";VITICULTEUR;" $4 ";;ACTIF;;" $14 ";;;" $5 ";" $6 ";" $7 ";;" $8 ";" $10 ";" $12 ";FR;" $18 ";" $15 ";;" $16 ";" $17 ";;"  }' > $DATA_DIR/societes.csv

php symfony import:societe $DATA_DIR/societes.csv

cat $DATA_DIR/producteurs_produits.csv | awk -F ";" '{ print $2 ";" $2 ";VITICULTEUR;" $4 ";ACTIF;;" $3 ";;;;" $5 ";" $6 ";" $7 ";;" $8 ";" $10 ";" $12 ";FR;" $18 ";" $15 ";;" $16 ";" $17 ";;"  }' > $DATA_DIR/etablissements.csv

php symfony import:etablissement $DATA_DIR/etablissements.csv