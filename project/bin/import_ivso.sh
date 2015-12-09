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

echo "Import de la configuration"

curl -X DELETE "http://$COUCHHOST:$COUCHPORT/$COUCHBASE/CONFIGURATION"?rev=$(curl -sX GET "http://$COUCHHOST:$COUCHPORT/$COUCHBASE/CONFIGURATION" | grep -Eo '"_rev":"[a-z0-9-]+"' | sed 's/"//g' | sed 's/_rev://')
php symfony import:configuration CONFIGURATION data/import/configuration/ivso
php symfony cc

cat $DATA_DIR/produits.csv | tr -d '\r' | awk -F ";" '{ print $5 ";" $4 }' | sort -t ";" -k 1,1 | sed 's/IGP Lot Blanc/IGP Côte du Lot Blanc/' | sed 's/IGP Lot Rouge/IGP Côte du Lot Rouge/' | sed 's/IGP Lot Rosé/IGP Côte du Lot Rosé/' | sed 's/IGP Tarn/IGP Côtes du Tarn/' | sed 's/AOP Pacherenc du Vic Bilh Moelleux/AOP Pacherenc du Vic Bilh Blanc Moelleux/' | sed 's/Côtes du Brulhois/Brulhois/' | sed 's/AOP Gaillac  Blanc sec - Premières cotes/AOP Gaillac Premières côtes Blanc sec/' > $DATA_DIR/produits_conversion.csv
cat $DATA_DIR/cepages.csv | cut -d ";" -f 2,3 | sort -t ";" -k 1,1 > $DATA_DIR/cepages.csv.sorted

echo "Import des contacts"

#Affichage des entêtes en ligne
#head -n 1 /tmp/giilda/data_ivso_csv/contacts_extravitis.csv | tr ";" "\n" | awk -F ";" 'BEGIN { nb=0 } { nb = nb + 1; print nb ";" $0 }'

cat $DATA_DIR/contacts_extravitis.csv | tr -d '\r' | awk -F ';' '
function ltrim(s) { sub(/^[ \t\r\n]+/, "", s); return s } function rtrim(s) { sub(/[ \t\r\n]+$/, "", s); return s } function trim(s)  { return rtrim(ltrim(s)); } { 
famille="AUTRE" ; 
famille=($13 ? "VITICULTEUR" : famille ) ; 
famille=($14 ? "NEGOCIANT" : famille ) ; 
famille=($15 ? "COURTIER" : famille ) ; 
statut=($37 == "Oui" ? "SUSPENDU" : "ACTIF") ; 
print $1 ";" famille ";" trim($2 " " $3 " " $4) ";;" statut ";;" $34 ";;;" $5 ";" $6 ";" $7 ";;" $9 ";" $10 ";" $12 ";FR;" $19 ";" $16 ";;" $18 ";" $17 ";" $20 ";" 
}' > $DATA_DIR/societes.csv

cat $DATA_DIR/contacts_extravitis.csv | tr -d '\r' | awk -F ';' '
function ltrim(s) { sub(/^[ \t\r\n]+/, "", s); return s } function rtrim(s) { sub(/[ \t\r\n]+$/, "", s); return s } function trim(s)  { return rtrim(ltrim(s)); } { 
nom=trim($2 " " $3 " " $4) ; 
famille="AUTRE" ; 
famille=($13 ? "VITICULTEUR" : famille ) ; 
famille=($14 ? "NEGOCIANT" : famille ) ; 
famille=($15 ? "COURTIER" : famille ) ; 
statut=($37 == "Oui" ? "SUSPENDU" : "ACTIF") ; 
nom=nom ; 
if (famille == "AUTRE") next ; 
print $1 ";" $1 ";" famille ";" nom ";" statut ";HORS_REGION;" $27 ";;;;" $5 ";" $6 ";" $7 ";;" $9 ";" $10 ";" $12 ";FR;" $19 ";" $16 ";;" $18 ";" $17 ";" $20 ";" 
}' > $DATA_DIR/etablissements.csv


#cat $DATA_DIR/producteurs.csv | cut -d ";" -f 2 | grep -E "^[0-9]+" | sed 's/$/;VITICULTEUR/' > $DATA_DIR/producteurs_ids
#cat $DATA_DIR/negociant.csv | cut -d ";" -f 2 | grep -E "^[0-9]+" | sed 's/$/;NEGOCIANT/' > $DATA_DIR/negociants_ids
#cat $DATA_DIR/courtier.csv | cut -d ";" -f 12 | grep -E "^[0-9]+" | sed 's/$/;COURTIER/' > $DATA_DIR/courtiers_ids
#cat $DATA_DIR/producteurs_ids $DATA_DIR/negociants_ids $DATA_DIR/courtiers_ids | sort -t ";" -k 1,1 > $DATA_DIR/operateurs_ids_familles

#cat $DATA_DIR/producteurs_produits.csv | sort -t ";" -k 2,2 > $DATA_DIR/producteurs_produits.sorted.csv

#join -t ";" -v 2 -1 1 -2 2 $DATA_DIR/operateurs_ids_familles $DATA_DIR/producteurs_produits.sorted.csv | cut -d ";" -f 1 | grep -E "^[0-9]+" | sed 's/$/;AUTRE/' > $DATA_DIR/autres_ids

#cat $DATA_DIR/producteurs_ids $DATA_DIR/negociants_ids $DATA_DIR/courtiers_ids $DATA_DIR/autres_ids | sort -t ";" -k 1,1 > $DATA_DIR/operateurs_ids_familles

#join -t ";" -1 1 -2 2 $DATA_DIR/operateurs_ids_familles $DATA_DIR/producteurs_produits.sorted.csv | sort -t ";" -k 1,1 > $DATA_DIR/operateurs.csv

#cat $DATA_DIR/operateurs.csv | awk -F ";" '{ print $1 ";" $2 ";" $5 ";;ACTIF;;" $15 ";;;" $6 ";" $7 ";" $8 ";;" $9 ";" $11 ";" $13 ";FR;" $19 ";" $16 ";;" $17 ";" $18 ";;"  }' > $DATA_DIR/societes.csv

#cat $DATA_DIR/operateurs.csv | grep -v ";AUTRE;" | awk -F ";" '{ print $1 ";" $1 ";" $2 ";" $5 ";ACTIF;HORS_REGION;" $4 ";;;;" $6 ";" $7 ";" $8 ";;" $9 ";" $11 ";" $13 ";FR;" $19 ";" $16 ";;" $17 ";" $18 ";;"  }' > $DATA_DIR/etablissements.csv

php symfony import:societe $DATA_DIR/societes.csv
php symfony import:etablissement $DATA_DIR/etablissements.csv

echo "Import des contrats"

cat $DATA_DIR/contrats.csv | tr -d "\n" | tr "\r" "\n" | sort -t ";" -k 16,16 > $DATA_DIR/contrats.csv.sorted.produits

join -a 1 -t ";" -1 16 -2 1 $DATA_DIR/contrats.csv.sorted.produits $DATA_DIR/produits_conversion.csv > $DATA_DIR/contrats_produits.csv

cat $DATA_DIR/contrats_produits.csv | sort -t ";" -k 24,24 > $DATA_DIR/contrats_produits.sorted.cepages

join -a 1 -t ";" -1 24 -2 1 $DATA_DIR/contrats_produits.sorted.cepages $DATA_DIR/cepages.csv.sorted > $DATA_DIR/contrats_produits_cepages.csv

cat $DATA_DIR/contrats_produits_cepages.csv | awk -F ';' '{ 
date_signature=gensub(/^([0-9]+)-([0-9]+)-([0-9]+)$/,"\\3-\\1-\\2","",$9); 
date_saisie=gensub(/^([0-9]+)-([0-9]+)-([0-9]+)$/,"\\3-\\1-\\2","",$11); 
libelle_produit=$41; 
print $4 ";" $7 ";"  date_signature ";" date_saisie ";VIN_VRAC;" $12 ";;" $13 ";" $14 ";" $2 ";" libelle_produit ";" $17 ";" $1 ";" $42 ";;;" $21 ";hl;" $23 ";;;" $21 ";" $22 ";" $24 ";" $24 ";" $33 ";" $32 ";;;;100_ACHETEUR;" $26 ";" $28 ";;" $30 
}' | grep -Ev '^[0-9]+;0;' | sort > $DATA_DIR/vracs.csv

php symfony import:vracs $DATA_DIR/vracs.csv

echo "Import des DRM"

cat $DATA_DIR/DRM.csv | tr -d "\r" | sort -t ";" -k 6,6 > $DATA_DIR/drm.csv.produits.sorted

join -a 1 -t ";" -1 6 -2 1  $DATA_DIR/drm.csv.produits.sorted $DATA_DIR/produits_conversion.csv | sort -t ";" -k 2,3 > $DATA_DIR/drm_produits.csv

cat $DATA_DIR/drm_produits.csv | awk -F ';' '{ 
base="CAVE;" $5 ";" $4 ";;" $37 ";;;;;;" ; 
print base "stocks_debut;revendique;" $10 ; 
print base "entrees;recolte;" $11 ;  #récolte
print base "entrees;revendication;" $12 ; #volume agréé
print base "?;declassement;" $13 ; #declassement
print base "sorties;destructionperte;" $14 ; #perte
print base "sorties;usageindustriel;" $15 ; #lie_et_mouts
print base "sorties;usageindustriel;" $16 ; #usages_industriels
print base "sorties;ventefrancebouteillecrd;" $17 ; #collective_ou_individuelle
print base "sorties;vracsanscontrat;" $18 ; #dsa_dsac
print base "sorties;vracsanscontrat;" $19 ; #facture_etc
print base "sorties;vracsanscontrat;" $20 ; #france_sans_contrat
print base "sorties;vrac;" $21 ; #france_sous_contrat
print base "sorties;export;" $22 ";UE" ;  #expedition_ue
print base "sorties;export;" $23 ";HORS UE" ; #expedition_hors_ue
print base "sorties;travailafacon;" $24 ; #relogement
print base "stocks_fin;revendique;" $25 ;
# print base "stocks?;dont_volume_bloque;" $26 ;
# print base "stocks?;quantite_gagees;" $27 ;
}' | grep -v ";0;" | grep -v ";0$" > $DATA_DIR/drm_edi.csv

cat $DATA_DIR/DRM_Factures.csv | tr -d "\r" | sort -t ";" -k 5,5 > $DATA_DIR/drm_factures.csv.produits.sorted

join -a 1 -t ";" -1 5 -2 1  $DATA_DIR/drm_factures.csv.produits.sorted $DATA_DIR/produits_conversion.csv > $DATA_DIR/drm_factures_produits.csv

cat $DATA_DIR/drm_factures_produits.csv | awk -F ';' '{
if (!$10 || $10 == "INCONNU") { next }
base="CAVE;" $5 ";" $17 ";;" $45 ";;;;;;" ; 
print base "sorties;vrac;" $21 ";;" $10 ; 
}' > $DATA_DIR/drm_edi_contrats.csv

cat $DATA_DIR/drm_edi.csv $DATA_DIR/drm_edi_contrats.csv | grep ";2015" | sort -t ";" -k 2,3 > $DATA_DIR/drm.csv

echo -n > $TMP/drm_lignes.csv

cat $DATA_DIR/drm.csv | while read ligne  
do
    if [ "$PERIODE" != "$(echo $ligne | cut -d ";" -f 2)" ] || [ "$IDENTIFIANT" != "$(echo $ligne | awk -F ';' '{ printf "%06d01", $3 }')" ]
    then
        if [ $(cat $TMP/drm_lignes.csv | wc -l) -gt 0 ]
        then
            php symfony drm:edi-import $TMP/drm_lignes.csv $PERIODE $IDENTIFIANT --trace
        fi
        echo -n > $TMP/drm_lignes.csv
    fi
    PERIODE=$(echo $ligne | cut -d ";" -f 2)
    IDENTIFIANT=$(echo $ligne | awk -F ';' '{ printf "%06d01", $3 }')

    echo $ligne >> $TMP/drm_lignes.csv
done