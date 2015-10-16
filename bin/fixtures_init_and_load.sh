#!/bin/bash

cd $(dirname $0)/..

DBNAME=$(cat project/config/databases.yml | grep -A 4 couchdb | grep dbname | sed 's/.*:  *//')
DBURL=$(cat project/config/databases.yml  | grep -A 4 couchdb | grep dsn | sed 's/.*:  *//')

if test "$1"; then
    echo "Pour supprimer la base, taper O comme Oui"
    read oui
    if test "$oui" = "O"; then
	curl -s -X DELETE $DBURL$DBNAME
    fi
fi

if ! curl -s $DBURL$DBNAME | grep true > /dev/null ; then
	curl -s -X PUT $DBURL$DBNAME
fi

curl -s -X PUT -d '{"_id": "COMPTE-7523700100", "type": "Compte","identifiant": "7523700100","civilite": null,"prenom": null,"nom": "M. Actualys Jean","nom_a_afficher": "M. Actualys Courtier","fonction": null,"commentaire": null,"origines": ["SOCIETE-7523700100"],"id_societe": "SOCIETE-7523700100","adresse_societe": 1,"adresse": "Le Giron","adresse_complementaire": null,"code_postal": "75001","commune": "PARIS","compte_type": "SOCIETE","cedex": null,"pays": "FR","email": "contact@actualys.com","telephone_perso": "","telephone_bureau": "01.00.00.00.00","telephone_mobile": "01.00.00.00.00","fax": "","interpro": "INTERPRO-declaration","statut": "ACTIF","tags": {"automatique": ["societe"]},"droits": ["transactions"]}' $DBURL$DBNAME/COMPTE-7523700100

curl -s -X PUT -d '{ "_id": "ETABLISSEMENT-752370010001", "type": "Etablissement", "cooperative": null, "interpro": "INTERPRO-declaration", "identifiant": "752370010001", "id_societe": "SOCIETE-7523700100", "statut": "ACTIF", "raisins_mouts": null, "exclusion_drm": null, "relance_ds": null, "recette_locale": { "id_douane": null, "nom": null, "ville": null }, "region": "HORS_REGION", "type_dr": null, "liaisons_operateurs": { }, "site_fiche": null, "compte": "COMPTE-7523700100", "num_interne": null, "raison_sociale": "M. Actualys Courtier", "nom": "M. Actualys Courtier", "cvi": null, "no_accises": null, "carte_pro": null, "famille": "COURTIER", "sous_famille": "CAVE_PARTICULIERE", "email": null, "telephone": null, "fax": null, "commentaire": null, "siege": { "adresse": "Le Giron", "code_postal": "75001", "commune": "PARIS" }, "comptabilite": { "adresse": null, "code_postal": null, "commune": null } }' $DBURL$DBNAME/ETABLISSEMENT-752370010001

curl -s -X PUT -d '{ "_id": "SOCIETE-7523700100", "type": "Societe", "identifiant": "7523700100", "type_societe": "COURTIER", "raison_sociale": "M. Actualys Courtier", "raison_sociale_abregee": "Actualys Courtier", "statut": "ACTIF", "code_comptable_client": null, "code_comptable_fournisseur": null, "code_naf": null, "siret": null, "interpro": "INTERPRO-declaration", "no_tva_intracommunautaire": null, "email": "actualys@example.org", "telephone": "01.00.00.00.00", "fax": "", "commentaire": null, "siege": { "adresse": "rue Garnier", "code_postal": "75001", "commune": "Paris", "pays": "FR" }, "cooperative": null, "enseignes": [ ], "compte_societe": "COMPTE-7523700100", "contacts": { "COMPTE-7523700100": { "nom": "M. Actualys Courtier", "ordre": 0 } }, "etablissements": { "ETABLISSEMENT-752370010001": { "nom": "M. Actualys Courtier", "ordre": null } }, "date_modification": "2015-02-20" }' $DBURL$DBNAME/SOCIETE-7523700100

curl -s -X PUT -d '{"_id": "COMPTE-7823700100", "type": "Compte","identifiant": "7823700100","civilite": null,"prenom": null,"nom": "M. Actualys Viti","nom_a_afficher": "M. Actualys Viti","fonction": null,"commentaire": null,"origines": ["SOCIETE-7823700100"],"id_societe": "SOCIETE-7823700100","adresse_societe": 1,"adresse": "Le Giron","adresse_complementaire": null,"code_postal": "78100","commune": "ST GERMAIN","compte_type": "SOCIETE","cedex": null,"pays": "FR","email": "contact@actualys.com","telephone_perso": "","telephone_bureau": "01.00.00.00.00","telephone_mobile": "01.00.00.00.00","fax": "","interpro": "INTERPRO-declaration","statut": "ACTIF","tags": {"automatique": ["societe"]},"droits": ["transactions"]}' $DBURL$DBNAME/COMPTE-7823700100

curl -s -X PUT -d '{ "_id": "ETABLISSEMENT-782370010001", "type": "Etablissement", "cooperative": null, "interpro": "INTERPRO-declaration", "identifiant": "782370010001", "id_societe": "SOCIETE-7823700100", "statut": "ACTIF", "raisins_mouts": null, "exclusion_drm": null, "relance_ds": null, "recette_locale": { "id_douane": null, "nom": null, "ville": null }, "region": "HORS_REGION", "type_dr": null, "liaisons_operateurs": { }, "site_fiche": null, "compte": "COMPTE-7823700100", "num_interne": null, "raison_sociale": "M. Actualys Jean", "nom": "M. Actualys Viti", "cvi": null, "no_accises": null, "carte_pro": null, "famille": "PRODUCTEUR", "sous_famille": "CAVE_PARTICULIERE", "email": null, "telephone": null, "fax": null, "commentaire": null, "siege": { "adresse": "Le Giron", "code_postal": "78100", "commune": "ST GERMAIN" }, "comptabilite": { "adresse": null, "code_postal": null, "commune": null }, "crd_regime": "COLLECTIFACQUITTE" }' $DBURL$DBNAME/ETABLISSEMENT-782370010001

curl -s -X PUT -d '{ "_id": "SOCIETE-7823700100", "type": "Societe", "identifiant": "7823700100", "type_societe": "VITICULTEUR", "raison_sociale": "M. Actualys Viti", "raison_sociale_abregee": "Actualys Viti", "statut": "ACTIF", "code_comptable_client": null, "code_comptable_fournisseur": null, "code_naf": null, "siret": null, "interpro": "INTERPRO-declaration", "no_tva_intracommunautaire": null, "email": "actualys@example.org", "telephone": "01.00.00.00.00", "fax": "", "commentaire": null, "siege": { "adresse": "rue Garnier", "code_postal": "78100", "commune": "St Germain", "pays": "FR" }, "cooperative": null, "enseignes": [ ], "compte_societe": "COMPTE-7823700100", "contacts": { "COMPTE-7823700100": { "nom": "M. Actualys Viti", "ordre": 0 } }, "etablissements": { "ETABLISSEMENT-782370010001": { "nom": "M. Actualys Viti", "ordre": null } }, "date_modification": "2015-02-20" }' $DBURL$DBNAME/SOCIETE-7823700100

curl -s -X PUT -d '{"_id": "COMPTE-9223700100", "type": "Compte","identifiant": "9223700100","civilite": null,"prenom": null,"nom": "M. Actualys Négo","nom_a_afficher": "M. Actualys Négo","fonction": null,"commentaire": null,"origines": ["SOCIETE-9223700100"],"id_societe": "SOCIETE-9223700100","adresse_societe": 1,"adresse": "Le Giron","adresse_complementaire": null,"code_postal": "92100","commune": "BOULOGNE","compte_type": "SOCIETE","cedex": null,"pays": "FR","email": "contact@actualys.com","telephone_perso": "","telephone_bureau": "01.00.00.00.00","telephone_mobile": "01.00.00.00.00","fax": "","interpro": "INTERPRO-declaration","statut": "ACTIF","tags": {"automatique": ["societe"]},"droits": ["transactions"]}' $DBURL$DBNAME/COMPTE-9223700100

curl -s -X PUT -d '{ "_id": "ETABLISSEMENT-922370010001", "type": "Etablissement", "cooperative": null, "interpro": "INTERPRO-declaration", "identifiant": "922370010001", "id_societe": "SOCIETE-9223700100", "statut": "ACTIF", "raisins_mouts": null, "exclusion_drm": null, "relance_ds": null, "recette_locale": { "id_douane": null, "nom": null, "ville": null }, "region": "HORS_REGION", "type_dr": null, "liaisons_operateurs": { }, "site_fiche": null, "compte": "COMPTE-922370010001", "num_interne": null, "raison_sociale": "M. Actualys Négo", "nom": "M. Actualys Négo", "cvi": null, "no_accises": null, "carte_pro": null, "famille": "NEGOCIANT", "sous_famille": "CAVE_PARTICULIERE", "email": null, "telephone": null, "fax": null, "commentaire": null, "siege": { "adresse": "Le Giron", "code_postal": "92100", "commune": "PARIS" }, "comptabilite": { "adresse": null, "code_postal": null, "commune": null } }' $DBURL$DBNAME/ETABLISSEMENT-922370010001

curl -s -X PUT -d '{ "_id": "SOCIETE-9223700100", "type": "Societe", "identifiant": "9223700100", "type_societe": "NEGOCIANT", "raison_sociale": "M. Actualys Négo", "raison_sociale_abregee": "Actualys Négo", "statut": "ACTIF", "code_comptable_client": null, "code_comptable_fournisseur": null, "code_naf": null, "siret": null, "interpro": "INTERPRO-declaration", "no_tva_intracommunautaire": null, "email": "actualys@example.org", "telephone": "01.00.00.00.00", "fax": "", "commentaire": null, "siege": { "adresse": "rue Garnier", "code_postal": "92100", "commune": "St Germain", "pays": "FR" }, "cooperative": null, "enseignes": [ ], "compte_societe": "COMPTE-9223700100", "contacts": { "COMPTE-9223700100": { "nom": "M. Actualys Négo", "ordre": 0 } }, "etablissements": { "ETABLISSEMENT-922370010001": { "nom": "M. Actualys Négo", "ordre": null } }, "date_modification": "2015-02-20" }' $DBURL$DBNAME/SOCIETE-9223700100

curl -s -X PUT -d '{"_id": "COMPTE-9523700100", "type": "Compte","identifiant": "9523700100","civilite": null,"prenom": null,"nom": "M. Actualys Négo","nom_a_afficher": "M. Actualys Négo","fonction": null,"commentaire": null,"origines": ["SOCIETE-9523700100"],"id_societe": "SOCIETE-9523700100","adresse_societe": 1,"adresse": "Le Giron","adresse_complementaire": null,"code_postal": "92100","commune": "BOULOGNE","compte_type": "SOCIETE","cedex": null,"pays": "FR","email": "contact@actualys.com","telephone_perso": "","telephone_bureau": "01.00.00.00.00","telephone_mobile": "01.00.00.00.00","fax": "","interpro": "INTERPRO-declaration","statut": "ACTIF","tags": {"automatique": ["societe"]},"droits": ["transactions"]}' $DBURL$DBNAME/COMPTE-9523700100

curl -s -X PUT -d '{
   "_id": "ETABLISSEMENT-9523700100",
   "type": "Etablissement",
   "cooperative": null,
   "interpro": "INTERPRO-declaration",
   "identifiant": "9523700100",
   "id_societe": "SOCIETE-9523700100",
   "statut": "ACTIF",
   "raisins_mouts": null,
   "exclusion_drm": null,
   "relance_ds": null,
   "recette_locale": {
       "id_douane": null,
       "nom": null,
       "ville": null
   },
   "region": "HORS_REGION",
   "type_dr": null,
   "liaisons_operateurs": {
   },
   "site_fiche": null,
   "compte": "COMPTE-9523700100",
   "num_interne": null,
   "raison_sociale": "M. Actualys Représentant",
   "nom": "M. Actualys Représentant",
   "cvi": 12345678912345,
   "no_accises": "FR01234567891234",
   "carte_pro": null,
   "famille": "REPRESENTANT",
   "sous_famille": null,
   "email": null,
   "telephone": null,
   "fax": null,
   "commentaire": null,
   "siege": {
       "adresse": "Le Giron",
       "code_postal": "95100",
       "commune": "ST EAUBONNE"
   },
   "comptabilite": {
       "adresse": null,
       "code_postal": null,
       "commune": null
   }
}' $DBURL$DBNAME/ETABLISSEMENT-9523700100

curl -s -X PUT -d '{ "_id": "SOCIETE-9523700100", "type": "Societe", "identifiant": "9523700100", "type_societe": "VITICULTEUR", "raison_sociale": "M. Actualys Représentant", "raison_sociale_abregee": "Actualys Représentant", "statut": "ACTIF", "code_comptable_client": null, "code_comptable_fournisseur": null, "code_naf": null, "siret": null, "interpro": "INTERPRO-declaration", "no_tva_intracommunautaire": null, "email": "actualys@example.org", "telephone": "01.00.00.00.00", "fax": "", "commentaire": null, "siege": { "adresse": "rue Garnier", "code_postal": "92100", "commune": "St Germain", "pays": "FR" }, "cooperative": null, "enseignes": [ ], "compte_societe": "COMPTE-9223700100", "contacts": { "COMPTE-9223700100": { "nom": "M. Actualys Représentant", "ordre": 0 } }, "etablissements": { "ETABLISSEMENT-9523700100": { "nom": "M. Actualys Représentant", "ordre": null } }, "date_modification": "2015-02-20" }' $DBURL$DBNAME/SOCIETE-9523700100

curl -s -X PUT -d '{ "_id": "CONFIGURATION", "type": "Configuration", "campagne": null, "factures": { "VIDE": "TEMPLATE-FACTURE-VIDE", "MODELE_TEMPLATE": "TEMPLATE-MODELE-FACTURE" }, "labels": { "agriculture_biologique": "Agriculture Biologique" }, "contenances": { "75 cl": 0.0075, "1 L": 0.01, "1.5 L": 0.015, "3 L": 0.03, "BIB 3 L": 0.03, "6 L": 0.06 }, "droits": { "CVO": "Cvo" }, "libelle_detail_ligne": { "stocks_debut": { "instance": { "libelle": "Revendication", "libelle_long": "Vin en instance de revendication", "description": "Vin en instance de revendication" }, "revendique": { "libelle": "Stock revendiqué dbt de mois", "libelle_long": "Stock revendiqué dbt de mois", "description": "Stock revendiqué dbt de mois" } }, "entrees": { "achatcrd": { "libelle": "Achat CRD", "libelle_long": "Achat de vin en CRD", "description": "Achat de vin en CRD" }, "achatnoncrd": { "libelle": "Achat non CRD", "libelle_long": "Achat de vin non CRD", "description": "Achat de vin non CRD" }, "declassement": { "libelle": "Déclassement", "libelle_long": "Déclassement", "description": "Déclassement" }, "regularisation": { "libelle": "Régularisation", "libelle_long": "Régularisation", "description": "Régularisation" }, "transfertsinternes": { "libelle": "Transfert interne", "libelle_long": "Transferts internes d'"'"'un chai à un autre", "description": "Transferts internes d'"'"'un chai à un autre" }, "repli": { "libelle": "Repli", "libelle_long": "Repli", "description": "Repli" }, "travailafacon": { "libelle": "Travail à façon", "libelle_long": "Retour d'"'"'embouteillage, relogement, travail à façon, distillation à façon", "description": "Retour d'"'"'embouteillage, relogement, travail à façon, distillation à façon" }, "retourmarchandisenontaxees": { "libelle": "Retour non taxé", "libelle_long": "Retour de marchandises non taxées", "description": "Retour de marchandises non taxées" }, "retourmarchandisetaxees": { "libelle": "Retour déjà taxé", "libelle_long": "Retour de marchandises ayant déjà été taxées", "description": "Retour de marchandises ayant déjà été taxées" }, "transfertcomptamatierecession": { "libelle": "Transfert externe", "libelle_long": "Transfert de comptabilité matière et cession", "description": "Transfert de comptabilité matière et cession" }, "vci": { "libelle": "VCI", "libelle_long": "VCI", "description": "VCI" }, "revendique": { "libelle": "Revendiqué", "libelle_long": "Volume revendiqué", "description": "Volume revendiqué" } }, "sorties": { "ventefrancebibcrd": { "libelle": "Bib CRD", "libelle_long": "Ventes en France de Bib sous CRD", "description": "Ventes en France de Bib sous CRD" }, "ventefrancebouteillecrd": { "libelle": "Bouteilles CRD", "libelle_long": "Ventes en France de Bouteilles sous CRD", "description": "Ventes en France de Bouteilles sous CRD" }, "cession": { "libelle": "Cession", "libelle_long": "Cession d'"'"'activité", "description": "Cession d'"'"'activité" }, "consommationfamilialedegustation": { "libelle": "Conso. Familiale", "libelle_long": "Consomation familiale et dégustation", "description": "Consomation familiale et dégustation" }, "vrac": { "libelle": "Contrat", "libelle_long": "Contrat de vin en vrac ou conditionné", "description": "Contrat de vin en vrac ou conditionné" }, "declassement": { "libelle": "Déclassement", "libelle_long": "Déclassement", "description": "Déclassement" }, "destructionperte": { "libelle": "Destruction/perte", "libelle_long": "Destruction et pertes", "description": "Destruction et pertes" }, "manquant": { "libelle": "Manquant", "libelle_long": "Manquant", "description": "Manquant" }, "export": { "libelle": "Export", "libelle_long": "Export", "description": "Export" }, "contrathorsinterpro": { "libelle": "Contrats hors interloire", "libelle_long": "Contrats hors interloire", "description": "Contrats hors interloire" }, "transfertsinternes": { "libelle": "Transfert interne", "libelle_long": "Transferts internes d'"'"'un chai à un autre", "description": "Transferts internes d'"'"'un chai à un autre" }, "repli": { "libelle": "Repli", "libelle_long": "Repli", "description": "Repli" }, "travailafacon": { "libelle": "Travail à façon", "libelle_long": "Sortie d'"'"'embouteillage, relogement, travail à façon, distillation à façon", "description": "Sortie d'"'"'embouteillage, relogement, travail à façon, distillation à façon" }, "vci": { "libelle": "VCI", "libelle_long": "VCI", "description": "VCI" }, "vracsanscontratacquitte": { "libelle": "Vrac acquitté", "libelle_long": "Sortie de vrac sans contrat (acquitté)", "description": "Sortie de vrac sans contrat (acquitté)" }, "vracsanscontratsuspendu": { "libelle": "Vrac suspendu", "libelle_long": "Sortie de vrac sans contrat (suspendu)", "description": "Sortie de vrac sans contrat (suspendu)" }, "distillationusageindustriel": { "libelle": "Usages industr.", "libelle_long": "Distillation et usages industriels", "description": "Distillation et usages industriels" } }, "stocks_fin": { "instance": { "libelle": "En instance de revendication", "libelle_long": "En instance de revendication", "description": "En instance de revendication" }, "revendique": { "libelle": "Stock revendiqué fin de mois", "libelle_long": "Stock revendiqué fin de mois", "description": "Stock revendiqué fin de mois" } } }, "alias": { }, "declaration": { "certifications": { "AOC": { "libelle": "AOC", "format_libelle": "%g% %a% %m% %l%", "code": "AOC", "code_produit": null, "code_comptable": null, "code_douane": null, "departements": [ ], "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ { "date": "2015-08-01", "taux": 3.75, "code": "L387", "libelle": "Vins Tranquilles" }  ], "cvo": [ { "date": "1900-01-01", "taux": 4.5, "code": "CVO", "libelle": "Cvo" } ] } } }, "genres": { "TRANQ": { "libelle": null, "format_libelle": null, "code": "TRANQ", "code_produit": null, "code_comptable": null, "code_douane": null, "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ { "date": "2015-08-01", "taux": 3.75, "code": "L387", "libelle": "Vins Tranquilles" }  ], "cvo": [ { "date": "1900-01-01", "taux": 4.5, "code": "CVO", "libelle": "Cvo" } ] } } }, "departements": [ ], "appellations": { "ANJ": { "libelle": "Actualys", "format_libelle": "%g% %a% %m% %l% %co%", "code": "ACT", "code_produit": null, "code_comptable": null, "code_douane": null, "densite": "1.3", "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ ] } } }, "departements": [ ], "mentions": { "DEFAUT": { "libelle": null, "format_libelle": null, "code": null, "code_produit": null, "code_comptable": null, "code_douane": null, "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ ] } } }, "departements": [ ], "lieux": { "GAR": { "libelle": "Côteaux Garnier", "format_libelle": null, "code": "GAR", "code_produit": null, "code_comptable": null, "code_douane": null, "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ ] } } }, "departements": [ ], "couleurs": { "blanc": { "libelle": "Blanc", "format_libelle": null, "code": "3", "code_produit": null, "code_comptable": null, "code_douane": null, "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ ] } } }, "departements": [ ], "cepages": { "DEFAUT": { "libelle": null, "format_libelle": null, "code": null, "code_produit": "1001", "code_comptable": "1", "code_douane": "" } } }, "rouge": { "libelle": "Rouge", "format_libelle": null, "code": "1", "code_produit": null, "code_comptable": null, "code_douane": null, "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ ] } } }, "departements": [ ], "cepages": { "DEFAUT": { "libelle": null, "format_libelle": null, "code": null, "code_produit": "1002", "code_comptable": "2", "code_douane": "" } } } } }, "SAB": { "libelle": "Côteaux Sablons", "format_libelle": null, "code": "SAB", "code_produit": null, "code_comptable": null, "code_douane": null, "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ ] } } }, "departements": [ ], "couleurs": { "blanc": { "libelle": "Blanc", "format_libelle": null, "code": "3", "code_produit": null, "code_comptable": null, "code_douane": null, "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ ] } } }, "departements": [ ], "cepages": { "DEFAUT": { "libelle": null, "format_libelle": null, "code": null, "code_produit": "1003", "code_comptable": "3", "code_douane": "" } } }, "rouge": { "libelle": "Rouge", "format_libelle": null, "code": "1", "code_produit": null, "code_comptable": null, "code_douane": null, "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ ] } } }, "departements": [ ], "cepages": { "DEFAUT": { "libelle": null, "format_libelle": null, "code": null, "code_produit": "1004", "code_comptable": "4", "code_douane": "" } } } } } } } } } } }, "EFF": { "libelle": "Crémant", "format_libelle": "%g% %a% %m% %l%", "code": "EFF", "code_produit": null, "code_comptable": null, "code_douane": null, "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ { "date": "1900-01-01T00:00:00+01:00", "taux": 4, "code": "CVO", "libelle": "Cvo" } ] } } }, "departements": [ ], "appellations": { "ACT": { "libelle": "Actualys", "format_libelle": null, "code": "ACT", "code_produit": null, "code_comptable": null, "code_douane": null, "densite": "1.3", "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ { "date": "1900-01-01", "taux": 3.8, "code": "CVO", "libelle": "Cvo" } ] } } }, "departements": [ ], "mentions": { "DEFAUT": { "libelle": null, "format_libelle": null, "code": null, "code_produit": null, "code_comptable": null, "code_douane": null, "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ ] } } }, "departements": [ ], "lieux": { "DEFAUT": { "libelle": null, "format_libelle": null, "code": null, "code_produit": null, "code_comptable": null, "code_douane": null, "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ ] } } }, "departements": [ ], "couleurs": { "blanc": { "libelle": "Blanc", "format_libelle": null, "code": "3", "code_produit": null, "code_comptable": null, "code_douane": null, "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ ] } } }, "departements": [ ], "cepages": { "DEFAUT": { "libelle": null, "format_libelle": null, "code": null, "code_produit": "1005", "code_comptable": "5", "code_douane": "" } } } } } } } } } } } } } }, "detail": { "stocks_debut": { "revendique": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": 0, "vrac": 0, "facturable": 0, "douane_type": "STOCK", "douane_cat": null, "taxable_douane": 0 }, "instance": { "readable": 1, "writable": 0, "details": 0, "mouvement_coefficient": 0, "vrac": 0, "facturable": 0, "douane_type": "STOCK", "douane_cat": null, "taxable_douane": 0 } }, "entrees": { "vci": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": 1, "vrac": 0, "facturable": 0, "douane_type": "SUSPENDU", "douane_cat": "entrees-periode/mouvements-internes/integration-vci-agree", "taxable_douane": 0 }, "achatcrd": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": 1, "vrac": 0, "facturable": 0, "douane_type": "ACQUITTE", "douane_cat": "entrees-periode/achats-reintegrations", "taxable_douane": 0 }, "achatnoncrd": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": 1, "vrac": 0, "facturable": 0, "douane_type": "SUSPENDU", "douane_cat": "entrees-periode/volume-produit", "taxable_douane": 0 }, "regularisation": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": 1, "vrac": 0, "facturable": 0, "douane_type": "SUSPENDU", "douane_cat": "entrees-periode/autres-entrees", "taxable_douane": 0 }, "transfertsinternes": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": 1, "vrac": 0, "facturable": 0, "douane_type": "SUSPENDU", "douane_cat": "entrees-periode/mouvements-internes/replis-declassement-transfert-changement-appellation", "taxable_douane": 0 }, "repli": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": 1, "vrac": 0, "facturable": 0, "douane_type": "SUSPENDU", "douane_cat": "entrees-periode/mouvements-internes/replis-declassement-transfert-changement-appellation", "taxable_douane": 0 }, "declassement": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": 1, "vrac": 0, "facturable": 0, "douane_type": "SUSPENDU", "douane_cat": "entrees-periode/mouvements-internes/replis-declassement-transfert-changement-appellation", "taxable_douane": 0 }, "retourmarchandisenontaxees": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": 1, "vrac": 0, "facturable": 1, "douane_type": "SUSPENDU", "douane_cat": "entrees-periode/replacement-suspension", "taxable_douane": 0 }, "retourmarchandisetaxees": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": 1, "vrac": 0, "facturable": 1, "douane_type": "SUSPENDU", "douane_cat": "entrees-periode/replacement-suspension", "taxable_douane": 1 }, "transfertcomptamatierecession": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": 1, "vrac": 0, "facturable": 0, "douane_type": "SUSPENDU", "douane_cat": "entrees-periode/replacement-suspension", "taxable_douane": 0 }, "travailafacon": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": 1, "vrac": 0, "facturable": 0, "douane_type": "SUSPENDU", "douane_cat": "entrees-periode/mouvements-temporaires/travail-a-facon", "taxable_douane": 0 }, "revendique": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": 1, "vrac": 0, "facturable": 0, "douane_type": "SUSPENDU", "douane_cat": "entrees-periode/volume-produit", "taxable_douane": 0 } }, "sorties": { "vracsanscontratsuspendu": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": -1, "vrac": 0, "facturable": 1, "douane_type": "SUSPENDU", "douane_cat": "sorties-periode/sorties-avec-paiement-droits", "taxable_douane": 1 }, "vracsanscontratacquitte": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": -1, "vrac": 0, "facturable": 1, "douane_type": "ACQUITTE", "douane_cat": "sorties-periode/sorties-sans-paiement-droits", "taxable_douane": 0 }, "ventefrancebouteillecrd": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": -1, "vrac": 0, "facturable": 1, "douane_type": "MIXTE", "douane_cat": "sorties-periode/sorties-avec-paiement-droits", "taxable_douane": 1 }, "ventefrancebibcrd": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": -1, "vrac": 0, "facturable": 1, "douane_type": "MIXTE", "douane_cat": "sorties-periode/sorties-avec-paiement-droits", "taxable_douane": 1 }, "vrac": { "readable": 1, "writable": 1, "details": 1, "mouvement_coefficient": -1, "vrac": 1, "facturable": 1, "douane_type": "SUSPENDU", "douane_cat": "sorties-periode/sorties-sans-paiement-droits/sorties-definitives", "taxable_douane": 0 }, "contrathorsinterpro": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": -1, "vrac": 0, "facturable": 0, "douane_type": "SUSPENDU", "douane_cat": "sorties-periode/sorties-sans-paiement-droits/sorties-definitives", "taxable_douane": 0 }, "cession": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": -1, "vrac": 0, "facturable": 0, "douane_type": "SUSPENDU", "douane_cat": "sorties-periode/sorties-sans-paiement-droits/autres-sorties", "taxable_douane": 0 }, "consommationfamilialedegustation": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": -1, "vrac": 0, "facturable": 0, "douane_type": "SUSPENDU", "douane_cat": "sorties-periode/sorties-sans-paiement-droits/consomation-familiale-degustation", "taxable_douane": 0 }, "repli": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": -1, "vrac": 0, "facturable": 0, "douane_type": "SUSPENDU", "douane_cat": "sorties-periode/sorties-sans-paiement-droits/mouvements-internes/replis-declassement-transfert-changement-appellation", "taxable_douane": 0 }, "distillationusageindustriel": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": -1, "vrac": 0, "facturable": 0, "douane_type": "SUSPENDU", "douane_cat": "sorties-periode/sorties-sans-paiement-droits/mouvements-internes/autres-sorties", "taxable_douane": 0 }, "declassement": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": -1, "vrac": 0, "facturable": 0, "douane_type": "SUSPENDU", "douane_cat": "sorties-periode/sorties-sans-paiement-droits/mouvements-internes/replis-declassement-transfert-changement-appellation", "taxable_douane": 0 }, "transfertsinternes": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": -1, "vrac": 0, "facturable": 0, "douane_type": "SUSPENDU", "douane_cat": "sorties-periode/sorties-sans-paiement-droits/mouvements-internes/replis-declassement-transfert-changement-appellation", "taxable_douane": 0 }, "vci": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": -1, "vrac": 0, "facturable": 0, "douane_type": "SUSPENDU", "douane_cat": "sorties-periode/sorties-sans-paiement-droits/mouvements-internes/revendication-vci", "taxable_douane": 0 }, "travailafacon": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": -1, "vrac": 0, "facturable": 0, "douane_type": "SUSPENDU", "douane_cat": "sorties-periode/sorties-sans-paiement-droits/mouvements-temporaires/travail-a-facon", "taxable_douane": 0 }, "export": { "readable": 1, "writable": 1, "details": 1, "mouvement_coefficient": -1, "vrac": 0, "facturable": 1, "douane_type": "SUSPENDU", "douane_cat": "sorties-periode/sorties-sans-paiement-droits/sorties-definitives", "taxable_douane": 0 }, "destructionperte": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": -1, "vrac": 0, "facturable": 0, "douane_type": "SUSPENDU", "douane_cat": "sorties-periode/sorties-sans-paiement-droits/autres-sorties", "taxable_douane": 0 }, "manquant": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": -1, "vrac": 0, "facturable": 0, "douane_type": "SUSPENDU", "douane_cat": "sorties-periode/sorties-sans-paiement-droits/autres-sorties", "taxable_douane": 0 } }, "stocks_fin": { "revendique": { "readable": 1, "writable": 0, "details": 0, "mouvement_coefficient": 0, "vrac": 0, "facturable": 0, "douane_type": "STOCK", "douane_cat": null, "taxable_douane": 0 }, "instance": { "readable": 1, "writable": 0, "details": 0, "mouvement_coefficient": 0, "vrac": 0, "facturable": 0, "douane_type": "STOCK", "douane_cat": null, "taxable_douane": 0 } } } }, "mvts_favoris": { "entrees_achatnoncrd": "entrees_achatnoncrd", "entrees_revendique": "entrees_revendique", "sorties_export": "sorties_export", "sorties_vraccontrat": "sorties_vraccontrat", "sorties_vracsanscontratsuspendu": "sorties_vracsanscontratsuspendu", "sorties_ventefrancebouteillecrd": "sorties_ventefrancebouteillecrd", "sorties_consommationfamilialedegustation": "sorties_consommationfamilialedegustation" }}' $DBURL$DBNAME/CONFIGURATION


curl -s -X PUT -d '{ "_id": "CURRENT", "type": "Current", "configurations": { "2000-08-01": "CONFIGURATION" } }' $DBURL$DBNAME/CURRENT

curl -s -X PUT -d '{ "_id": "TEMPLATE-FACTURE-VIDE", "type": "TemplateFacture", "campagne": null, "template": "VIDE", "libelle": "Facture vierge", "docs": [ ], "cotisations": { "vierge": { "modele": "Cotisation", "callback": "", "libelle": "", "code_comptable": "", "details": { "vierge": { "modele": "CotisationFixe", "prix": null, "tva": null, "libelle": "Fixe", "complement_libelle": "",  "callback": "",  "docs": [  ]  }}}}}' $DBURL$DBNAME/TEMPLATE-FACTURE-VIDE


curl -s -X PUT -d '{ "_id": "TEMPLATE-MODELE-FACTURE", "type": "TemplateFacture", "campagne": null, "template": "MODELE", "libelle": "Exemple de template de facture", "docs": [ ], "cotisations": { "modele_template": { "modele": "Cotisation", "callback": "", "libelle": "Facture des cotisations", "code_comptable": "", "details": { "abonnement": { "modele": "CotisationFixe", "prix": "159.99", "tva": 0, "libelle": "Inscription Observatoire économique", "complement_libelle": "", "callback": "", "docs": [ ] }, "vinification": { "modele": "CotisationFixe", "prix": 152, "tva": 0, "libelle": "Taxe sur le vin revendiqué", "complement_libelle": "", "docs": [ ], "callback": "" }}}}}' $DBURL$DBNAME/TEMPLATE-MODELE-FACTURE

