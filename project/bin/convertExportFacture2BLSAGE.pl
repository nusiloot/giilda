#!/usr/bin/perl

use Encode;

use constant code_journal => 0;
use constant date => 1;
use constant date_de_saisie => 2;
use constant numero_de_facture => 3;
use constant libelle => 4;
use constant compte_general => 5;
use constant compte_tiers => 6;
use constant compte_analytique => 7;
use constant date_echeance => 8;
use constant sens => 9;
use constant montant => 10;
use constant piece => 11;
use constant reference => 12;
use constant id_couchdb => 13;
use constant type_ligne => 14;
use constant nom_client => 15;
use constant code_comptable_client => 16;
use constant origine_type => 17;
use constant produit_type => 18;
use constant origine_id => 19;
use constant volume => 20;
use constant cvo => 21;

$verbose = shift;

sub printCHEN {
    print "#CHEN\n";
    print "Domaine;" if ($verbose);
    print "1\n";
    print "Type;" if ($verbose);
    print "3\n";
    print "Provenance;" if ($verbose);
    print "1\n";
    print "Souche;" if ($verbose);
    print "1\n";
    print "n° de pièce;" if ($verbose);
    print $field[numero_de_facture]."\n";
    print "Date;" if ($verbose);
    print $field[date]."\n";
    print "Référence;" if ($verbose);
    print $field[numero_de_facture]."\n";
    print "Livraison réalisée;" if ($verbose);
    print "\n";
    print "livraison;" if ($verbose);
    print $field[date]."\n";
    print "Date expérdition /!\;" if ($verbose);
    print "\n";
    print "Tiers;" if ($verbose);
    print $field[nom_client]."\n";
    print "Dépot de stockage;" if ($verbose);
    print "CIVRB\n";
    print "Dépot de livraison;" if ($verbose);
    print "\n";
    print "Périodicité;" if ($verbose);
    print "1\n";
    print "devise;" if ($verbose);
    print "0\n";
    print "cours;" if ($verbose);
    print "0\n";
    print "payer;" if ($verbose);
    print "2\n";
    print "expédition;" if ($verbose);
    print "1\n";
    print "condition;" if ($verbose);
    print "1\n";
    print "langue;" if ($verbose);
    print "0\n";
    print "nom répresantant;" if ($verbose);
    print "\n";
    print "prénom représentant;" if ($verbose);
    print "\n";
    print "entete;" if ($verbose);
    print "\n";
    print "entete;" if ($verbose);
    print "\n";
    print "entete;" if ($verbose);
    print "\n";
    print "entete;" if ($verbose);
    print "\n";
    print "affaire;" if ($verbose);
    print "\n";
    print "categorie;" if ($verbose);
    print "1\n";
    print "regime;" if ($verbose);
    print "21\n";
    print "transaction;" if ($verbose);
    print "11\n";
    print "colissage;" if ($verbose);
    print "1\n";
    print "unité colissage;" if ($verbose);
    print "1\n";
    print "nbre exemplaire;" if ($verbose);
    print "1\n";
    print "bl/facture;" if ($verbose);
    print "0\n";
    print "tx escompte;" if ($verbose);
    print "0\n";
    print "ecart valorisation;" if ($verbose);
    print "0\n";
    print "categorie comptable;" if ($verbose);
    print "1\n";
    print "frais;" if ($verbose);
    print "0\n";
    print "statut;" if ($verbose);
    print "1\n";
    print "compte général;" if ($verbose);
    print $field[compte_general]."\n";
    print "heure;" if ($verbose);
    print "08:00:00\n";
    print "caisse;" if ($verbose);
    print "\n";
    print "caissier nom;" if ($verbose);
    print "\n";
    print "caissier prénom;" if ($verbose);
    print "\n";
    print "cloturé;" if ($verbose);
    print "0\n";
    print "Numéro de commande;" if ($verbose);
    print "\n";
    print "Ventilation IFRS;" if ($verbose);
    print "\n";
    print "type valeur calcul frais expédition;" if ($verbose);
    print "0\n";
    print "valeur frais expérdition;" if ($verbose);
    print "0\n";
    print "type valeur frais expédition;" if ($verbose);
    print "0\n";
    print "type valeur calcul franco de port;" if ($verbose);
    print "0\n";
    print "valeur franco de port;" if ($verbose);
    print "0\n";
    print "type valeur franco de port;" if ($verbose);
    print "0\n";
    print "taux taux 1;" if ($verbose);
    print "0\n";
    print "type taux taxe 1;" if ($verbose);
    print "0\n";
    print "type de taxe 1;" if ($verbose);
    print "0\n";
    print "taux taux 2;" if ($verbose);
    print "0\n";
    print "type taux taxe 2;" if ($verbose);
    print "0\n";
    print "type de taxe 2;" if ($verbose);
    print "0\n";
    print "taux taux 3;" if ($verbose);
    print "0\n";
    print "type taux taxe 3;" if ($verbose);
    print "0\n";
    print "type de taxe 3;" if ($verbose);
    print "0\n";
    print "motif;" if ($verbose);
    print "\n";
    print "centrale achat;" if ($verbose);
    print "\n";
    print "contact;" if ($verbose);
    print "\n";
    print "statut rectifié /!\;" if ($verbose);
    print "0\n";
    print "type transaction  /!\;" if ($verbose);
    print "0\n";
    print "validé;" if ($verbose);
    print "0\n";
    print "FA origine;" if ($verbose);
    print "\n";
}

sub printCHLI {
    print "#CHLI\n";
    print "Référence entete;" if ($verbose);
    print $field[numero_de_facture]."\n";
    print "Référence article;" if ($verbose);
    print "\n";
    print "Désignation;" if ($verbose);
    print encode_utf8(substr(decode_utf8($field[libelle]), 0, 69))."\n";
    print "Texte complémentaire;" if ($verbose);
    print "\n";
    print "Enuméré de gamme 1;" if ($verbose);
    print "\n";
    print "Enuméré de gamme 1;" if ($verbose);
    print "\n";
    print "n° de série;" if ($verbose);
    print "\n";
    print "complément;" if ($verbose);
    print "\n";
    print "date de présemtion;" if ($verbose);
    print "\n";
    print "date de fabrication;" if ($verbose);
    print "\n";
    print "type de prix;" if ($verbose);
    print "0\n";
    print "prix unitaire;" if ($verbose);
    print $field[cvo]."\n";
    print "prix unitaire en devise;" if ($verbose);
    print "0\n";
    print "quantité;" if ($verbose);
    print $field[volume]."\n";
    print "quantité cotisée;" if ($verbose);
    print "0\n";
    print "Conditionnement;" if ($verbose);
    print "0\n";
    print "poids net global;" if ($verbose);
    print "0\n";
    print "poids brut global;" if ($verbose);
    print "0\n";
    print "remise;" if ($verbose);
    print "\n";
    print "type de ligne;" if ($verbose);
    print "0\n";
    print "prix de revient unitaire;" if ($verbose);
    print $field[cvo]."\n";
    print "frais;" if ($verbose);
    print "0\n";
    print "CMUP;" if ($verbose);
    print $field[montant]."\n";
    print "provenance facture;" if ($verbose);
    print "0\n";
    print "Nom représenant;" if ($verbose);
    print "CIVRB\n";
    print "prénom représentant;" if ($verbose);
    print "\n";
    print "date de livraison;" if ($verbose);
    print "\n";
    print "dépôt de stockage;" if ($verbose);
    print "\n";
    print "affaiche;" if ($verbose);
    print "\n";
    print "valorisation;" if ($verbose);
    print "1\n";
    print "référence composé;" if ($verbose);
    print "0\n";
    print "artice non livré;" if ($verbose);
    print "0\n";
    print "taux taxe 1;" if ($verbose);
    print "20\n";
    print "type taux taxe 1;" if ($verbose);
    print "0\n";
    print "type taxe 1;" if ($verbose);
    print "0\n";
    print "taux taxe 2;" if ($verbose);
    print "0\n";
    print "type taux taxe 2;" if ($verbose);
    print "0\n";
    print "type taxe 2;" if ($verbose);
    print "0\n";
    print "taux taxe 3;" if ($verbose);
    print "0\n";
    print "type taux taxe 3;" if ($verbose);
    print "0\n";
    print "type taxe 3;" if ($verbose);
    print "0\n";
    print "Numéro tiers;" if ($verbose);
    print $field[compte_tiers]."\n";
    print "Référence fournisseur ;" if ($verbose);
    print "\n";
    print "ref client nan;" if ($verbose);
    print $field[compte_tiers]."\n";
    print "facturation sur poids net;" if ($verbose);
    print "0\n";
    print "hors escompte ;" if ($verbose);
    print "0\n";
    print "numero de colis;" if ($verbose);
    print "\n";
    print "code ressource;" if ($verbose);
    print "\n";
    print "qtt ressource;" if ($verbose);
    print "0\n";
    print "existance agenda;" if ($verbose);
    print "0\n";
    print "date avencement;" if ($verbose);
    print "\n";
    print "projet;" if ($verbose);
    print "\n";
    print "date;" if ($verbose);
    print $field[date]."\n";
    print "code emplacement;" if ($verbose);
    print "\n";
    print "qtt emplacement;" if ($verbose);
    print "\n";
}

sub printCHRE {
    print "#CHRE\n";
    print "Type;" if ($verbose);
    print "1\n";
    print "Date;" if ($verbose);
    print $field[date]."\n";
    print "libellé;" if ($verbose);
    print "\n";
    print "montant;" if ($verbose);
    print "0\n";
    print "montant en devise;" if ($verbose);
    print "0\n";
    print "mode règlement;" if ($verbose);
    print "4\n";
    print "cloturé;" if ($verbose);
    print "0\n";
    print "numéro de pièce;" if ($verbose);
    print "\n";
}

sub printCIVA {
    $nom = $numero = $field[origine_type];
    $nom =~ s/.* \(([^\)]*)\).*/$1/;
    $numero =~ s/.*Contrat n° *(\d+) .*/$1/;
    print "#CIVA\n";
    print "Nom tiers contrat;" if ($verbose);
    print $nom."\n";
    print "Numéro de contrat;" if ($verbose);
    print $numero."\n";
    print "Date;" if ($verbose);
    print $field[date_de_saisie]."\n";
}

print "#VER 19\n";
while(<STDIN>) {
	chomp;
	@field = split/;/ ;
	next if ($field[code_journal] ne 'VEN');
	next if (!$field[montant]); #si montant à 0, l'ignorer
	$field[date] =~ s/\d{2}(\d{2})-(\d{2})-(\d{2})/${3}${2}${1}/;
	$field[date_de_saisie] =~ s/\d{2}(\d{2})-(\d{2})-(\d{2})/${3}${2}${1}/;
	printCHEN if ($old ne $field[numero_de_facture]) ;
	$old = $field[numero_de_facture];
	printCHLI if ($field[sens] eq 'CREDIT');
	printCIVA if ($field[sens] eq 'CREDIT' && $field[origine_type]);
	printCHRE if ($field[sens] eq 'DEBIT');
}
print "#FIN\n";
