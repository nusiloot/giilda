<?php use_helper('Date') ?>
\documentclass[a4paper,8pt]{extarticle}
\usepackage{geometry} % paper=a4paper
\usepackage[french]{babel}
\usepackage[utf8x]{inputenc}
\usepackage{geometry}
\usepackage{graphicx}
\usepackage[table]{xcolor}
\usepackage{multicol}
\usepackage{tabularx}
\usepackage{amssymb}
\usepackage{tikz}
\usepackage{textcomp}

\usepackage[explicit]{titlesec}
\usepackage{lipsum}

\newcommand*\circled[1]{\tikz[baseline=(char.base)]{
            \node[shape=circle,draw,inner sep=2pt] (char) {#1};}}

\titleformat{\section}
  {\normalfont\bfseries}{\circled\thesection}{1em}{#1}

\renewcommand{\familydefault}{\sfdefault}
\newcommand{\euro}{\EUR\xspace}

\newcommand{\squareChecked}{\makebox[0pt][l]{$\square$}\raisebox{.15ex}{\hspace{0.1em}$\checkmark$}}

\setlength{\oddsidemargin}{-2cm}
\setlength{\evensidemargin}{-2cm}
\setlength{\textwidth}{20cm}
\setlength{\textheight}{27.9cm}
\setlength{\topmargin}{-3.5cm}
\setlength{\parindent}{0pt}

\def\tabularxcolumn#1{m{#1}}

\def\IVBDCOORDONNEESTITRE{Interprofession des Vins de Bergerac et Duras}
\def\IVBDCOORDONNEESADRESSE{1, rue des Récollets Test - BP 426 - 24104 BERGERAC Cedex - Tél. 01 01 01 01 01 - Fax: 02 02 02 02 02}


\def\CONTRATNUMENREGISTREMENT{<?php echo substr($vrac->numero_contrat, -6)?>}
\def\CONTRATANNEEENREGISTREMENT{<?php echo substr($vrac->numero_contrat, 2, 2)?>}
\def\CONTRATVISA{Pas de visa}
\def\CONTRATDATEENTETE{}

\def\CONTRAT_TITRE{CONTRAT D'ACHAT EN PROPRIETE}


\def\CONTRATVENDEURNOM{<?php echo $vrac->vendeur->raison_sociale ?><?php if ($vrac->responsable == 'vendeur'): ?> (responsable)<?php endif; ?>}
\def\CONTRATVENDEURCVI{<?php echo $vrac->vendeur->cvi ?>}
\def\CONTRATVENDEURADRESSE{<?php echo $vrac->vendeur->adresse.' '.$vrac->vendeur->code_postal.' '.$vrac->vendeur->commune ?>}
\def\CONTRATVENDEURTELEPHONE{<?php echo $vrac->getVendeurObject()->telephone ?>}
\def\CONTRATVENDEURPAYEUR{<?php echo $vrac->representant->raison_sociale ?>}

\def\CONTRATACHETEURNOM{<?php echo $vrac->acheteur->raison_sociale ?><?php if ($vrac->responsable == 'acheteur'): ?> (responsable)<?php endif; ?>}
\def\CONTRATACHETEURCVI{<?php echo $vrac->acheteur->cvi ?>}
\def\CONTRATACHETEURADRESSE{<?php echo $vrac->acheteur->adresse.' '.$vrac->acheteur->code_postal.' '.$vrac->acheteur->commune ?>}
\def\CONTRATACHETEURTELEPHONE{<?php echo $vrac->getAcheteurObject()->telephone ?>}

\def\CONTRATCOURTIERNOM{<?php echo $vrac->mandataire->raison_sociale ?><?php if ($vrac->responsable == 'mandataire'): ?> (responsable)<?php endif; ?>}
\def\CONTRATCOURTIERCARTEPRO{<?php echo $vrac->mandataire->carte_pro ?>}
\def\CONTRATCOURTIERADRESSE{<?php echo $vrac->mandataire->adresse.' '.$vrac->mandataire->code_postal.' '.$vrac->mandataire->commune ?>}
\def\CONTRATCOURTIERTELEPHONE{<?php echo ($vrac->mandataire_identifiant)? $vrac->getMandataireObject()->telephone : null; ?>}


\def\CONTRATVOLUMEENTOUTELETTRE{huit mille sept cents vingt trois}
\def\CONTRATVOLUME{<?php echo ($vrac->jus_quantite)? $vrac->jus_quantite : $vrac->raisin_quantite ?>}
\def\CONTRATAPPELLATIONPRODUIT{<?php echo $vrac->produit_libelle ?>}
\def\CONTRATCEPAGEPRODUIT{<?php echo $vrac->cepage_libelle ?>}
\def\CONTRATCOULEURPRODUIT{??}
\def\CONTRATMILLESIMEPRODUIT{<?php echo $vrac->millesime ?>}
\def\CONTRATLIEUPRODUIT{<?php echo ($vrac->logement)? $vrac->logement : $vrac->vendeur->commune ?>}
\def\CONTRATNOMPRODUIT{<?php echo ($vrac->autorisation_nom_vin)? VracConfiguration::getInstance()->getCategories()[$vrac->categorie_vin].' '.$vrac->domaine : ''; ?>}

\def\CONTRATBORDEREUPOURCENTAGEANNEEUN{<?php echo $vrac->pourcentage_variation ?>}
\def\CONTRATSEUILDECLENCHEMENT{<?php echo $vrac->seuil_revision ?>}
\def\CONTRATNUMEROENREGISTREMENTANNEEUN{<?php echo $vrac->reference_contrat ?>}

\def\CONTRATPRIXTOUTELETTRE{cinq mille deux cents trente}
\def\CONTRATPRIX{<?php echo $vrac->prix_initial_unitaire ?>}
\def\CONTRATMOYENPAIEMENT{<?php echo VracConfiguration::getInstance()->getMoyensPaiement()[$vrac->moyen_paiement] ?>}
\def\CONTRATDELAIPAIEMENT{<?php echo VracConfiguration::getInstance()->getDelaisPaiement()[$vrac->delai_paiement] ?>}

\def\CONTRATPOURCENTAGECOURTAGE{<?php echo $vrac->taux_courtage ?>}
\def\CONTRATREPARTITION{<?php echo str_replace('%', '\%', VracConfiguration::getInstance()->getRepartitionCvo()[$vrac->cvo_repartition]); ?>}

\def\DATELIMITERETIRAISON{<?php echo format_date($vrac->date_limite_retiraison) ?>}
\def\SURFACECONTRAT{<?php echo $vrac->surface ?>}
\def\CONTRATOBSERVATIONS{<?php echo $vrac->conditions_particulieres ?>}

\begin{document}
\begin{minipage}[t]{0.6\textwidth}
\begin{center}
\begin{large}
\IVBDCOORDONNEESTITRE\\
\end{large}
~ \\
	\small{\IVBDCOORDONNEESADRESSE} \\ 
	~  \\
	\begin{large}
       \textbf{BORDEREAU DE CONFIRMATION D'ACHAT DE}\\
    \end{large}
    \textbf{- VENDANGES FRAICHES -}\\
    ~  \\
    n° IF - \CONTRATANNEEENREGISTREMENT - \begin{large}\textbf{\CONTRATNUMENREGISTREMENT} \end{large} \\ ~ \\ La liasse complète doit être adressée à l'IVBD pour enregistrement
    \\ dans un délai maximal de 10 jours après signature du présent bordereau
\end{center}	
\end{minipage}
\hspace{2cm}
  \begin{minipage}[t]{0.3\textwidth}
  \vspace{-0.5cm}
\begin{tabularx}{\textwidth}{|X|}
\hline
~ \\
	 \textbf{CACHET DE L'IVBD} \\ ~ \\ ~ \\ ~ \\ ~ \\ ~ \\ ~ \\ ~ \\ ~ \\ N° \begin{Large}
	  \CONTRATNUMENREGISTREMENT 
\end{Large}	 \\ ~ \\ 
\hline
\end{tabularx}
\end{minipage}

%PARTIE 1%
\circled{1}~~\textbf{Désignation des parties:} \\
\normalsize
\begin{minipage}[t]{0.6\textwidth}
\hspace*{0.5cm}
\textbf{A) VENDEUR} : \CONTRATVENDEURNOM \\
\hspace*{0.5cm}
Adresse : \CONTRATVENDEURADRESSE \\
<?php if ($vrac->vendeur_identifiant != $vrac->representant_identifiant): ?>
\hspace*{0.5cm}
Pour le compte de : \CONTRATVENDEURPAYEUR 
<?php endif; ?>
\\ ~ \\
\hspace*{0.5cm}
\textbf{B) ACHETEUR} : \CONTRATACHETEURNOM \\
\hspace*{0.5cm}
Adresse : \CONTRATACHETEURADRESSE \\ ~ \\ ~ \\ ~ \\
<?php if($vrac->mandataire_identifiant): ?>
\hspace*{0.5cm}
\textbf{C) COURTIER} : \CONTRATCOURTIERNOM \\
\hspace*{0.5cm}
Adresse : \CONTRATCOURTIERADRESSE 
<?php endif; ?>
\end{minipage}
\hspace{2cm}
\begin{minipage}[t]{0.3\textwidth}
N° CVI : \CONTRATVENDEURCVI \\
Tél. : \CONTRATVENDEURTELEPHONE \\ ~ \\ ~ \\
<?php if ($vrac->getAcheteurObject()->famille == EtablissementFamilles::FAMILLE_PRODUCTEUR): ?>
~Récoltant~\squareChecked~Négociant~$\square$ \\
<?php else: ?>
~Récoltant~$\square$~Négociant~\squareChecked \\
<?php endif; ?>
N° CVI : \CONTRATACHETEURCVI \\
Tél. : \CONTRATACHETEURTELEPHONE \\ ~ \\
<?php if($vrac->mandataire_identifiant): ?>
N° CIP : \CONTRATCOURTIERCARTEPRO \\
Tél. : \CONTRATCOURTIERTELEPHONE 
<?php endif; ?>
\end{minipage}
 ~ \\ ~ \\
%PARTIE 2%
\circled{2}~~\textbf{Désignation des produits :} \\
\normalsize
\hspace*{0.5cm}
La vendange concernée par ce contrat est issue du millésime \textbf{\CONTRATMILLESIMEPRODUIT} \\
\hspace*{0.5cm}
Assiette foncière totale correspondant aux volumes commercialisés : \SURFACECONTRAT ~ <?php echo VracConfiguration::getInstance()->getUnites()[$vrac->type_transaction]['surface']['libelle'] ?> \\
\hspace*{0.5cm}
Volume prévisionnel : \CONTRATVOLUME ~ Kg de raisin du cépage \CONTRATCEPAGEPRODUIT \\
\hspace*{0.5cm}
pouvant prétandre à l'appellation : \CONTRATAPPELLATIONPRODUIT \\
\hspace*{0.5cm}
Le vendeur s'engage à livrer à l'acheteur les raisins désignés ci-dessus, issus de sa production et conformes à l'ensemble des prescriptions figurant dans \\
\hspace*{0.5cm}
les cahiers des charges des vins concernés. Il certifie que les renseignements ci-dessus sont repris dans sa déclaration de récolte.
 ~ \\   ~ \\ 
%PARTIE 3%
\circled{3}~~\textbf{Bordereau s'inscrivant dans le cadre d'un contrat d'achat pluriannuel:}<?php if ($vrac->pluriannuel): ?>~Oui~\squareChecked~Non~$\square$<?php else : ?>~Oui~$\square$~Non~\squareChecked<?php endif; ?> $\rightarrow$ Préciser l'année d'application : Année 1 <?php if ($vrac->annee_contrat == 1): ?>\squareChecked<?php else : ?>$\square$<?php endif; ?> Année 2 <?php if ($vrac->annee_contrat == 2): ?>\squareChecked<?php else : ?>$\square$<?php endif; ?> Année 3 <?php if ($vrac->annee_contrat == 3): ?>\squareChecked<?php else : ?>$\square$<?php endif; ?> \\
\hspace*{0.5cm}
Le volume et le prix indiqués sur ce bordereau concernent l'année d'application cochée, sous réserve du respect des règles précisées au verso. \\\hspace*{0.5cm}
Année 1, préciser :\small ~- si une révision est envisagée pour les années suivante :<?php if ($vrac->seuil_revision || $vrac->pourcentage_variation): ?>~Oui~\squareChecked~Non~$\square$<?php else : ?>~Oui~$\square$~Non~\squareChecked<?php endif; ?> $\rightarrow$ Préciser le seuil de déclenchement de révision de prix du contrat $\pm$ \CONTRATSEUILDECLENCHEMENT\% \\
\hspace*{2.92cm}
- le pourcentage de variabilité maximale du volume en année 2 ou 3 par rapport au volume prévu en année 1 est de $\pm$ \CONTRATBORDEREUPOURCENTAGEANNEEUN\% \\
\hspace*{0.5cm}
\normalsize
En années 2 ou 3, préciser le n° d'enregistrement à l'IVBD du contrat initial déposé en année 1 : \CONTRATNUMEROENREGISTREMENTANNEEUN
 ~ \\   ~ \\ 
%PARTIE 4%
\circled{4}~~\textbf{Prix et conditions de paiement:} \\
\hspace*{0.5cm}
Le prix convenu est de ~\CONTRATPRIX~\texteuro / Kg \\
\hspace*{0.5cm}
Moyen de paiement : \CONTRATMOYENPAIEMENT \\
\hspace*{0.5cm}
Délais de paiement : \CONTRATDELAIPAIEMENT \\
\hspace*{0.5cm}
\tiny{Rappel : Les Accords Interprofessionnel de l'IVBD encadrent strictement, dans leur article 11, les delais de paiement maximaux. Lorsque les bordereaux prévoient des dates de retiraison, les délais de paiement ne peuvent excéder 60 jours calendaires\\
\hspace*{0.5cm}
après chacune des dates de retiraison prévues. Lorsque les bordereaux sont signés dans le cadre d'un contrat pluriannuel, les delais de paiement ne peuvent excéder 150 jours calendaires après chacune des dates de retiraison prévues. Dans tous les\\
\hspace*{0.5cm}
autres cas, les délais de paiement son ceux prévus à l'article L 443-1 du Code de Commerce.\\
\hspace*{0.5cm}
Des sanction financières conséquentes sont prévues par l'article L 632-7 du Code Rural et l'article L 443-1 du Code de Commerce (amende de 75 000 ) en cas de non respect de ces dispositions.} \\
\normalsize
\hspace*{0.5cm}
Le courtage de \CONTRATPOURCENTAGECOURTAGE \% est à la charge de \CONTRATREPARTITION.\\
\hspace*{0.5cm}
Le vendeur est assujetti à la TVA <?php if ($vrac->vendeur_tva): ?>~Oui~\squareChecked Non~$\square$<?php else: ?>~Oui~$\square$ Non~\squareChecked<?php endif;?> ~~~~~ La facturation se fera : <?php if ($vrac->tva == 'SANS'): ?>hors TVA \squareChecked ~~ avec TVA $\square$<?php else : ?>hors TVA $\square$ ~~ avec TVA \squareChecked<?php endif; ?>
  ~ \\   ~ \\ 
%PARTIE 5%
\circled{5}~~\textbf{Retiraison, Délivrance et Réserve de propriété:}\\
\hspace*{0.5cm}
La dernière retiraison sera effectuée au plus tard le \DATELIMITERETIRAISON.\\
\hspace*{0.5cm}
De convention expresse entre les parties, la délivrance au sens de l'article 1604 du Code Civil se réalisera à la date de retiraison indiquée sur\\
\hspace*{0.5cm}
le bordereau. Si la retiraison intervenait avant la date précitée, la délivrance serait imputée acquise à la date figurant sur le titre de mouvement.\\
\hspace*{0.5cm}
Les parties entendent placer le présent contrat sous le regime de laréserve de propriété prévu par la loi du 12 mai 1980. En application de cette loi,\\
\hspace*{0.5cm}
le vendeur se réserve la propriété des raisins vendus jusqu'à parfait paiement de ceux-ci.\\
  ~ \\   ~ \\ 
%PARTIE 6%
\circled{6}~~\textbf{Retiraison, Délivrance et Réserve de propriété:}\\
\hspace*{0.5cm}
Ce bordereau fait référence à un contrat assorti d'un cahier des charges établi entre le vendeur et l'acheteur : <?php if ($vrac->cahier_charge): ?>~Oui~\squareChecked Non~$\square$<?php else: ?>~Oui~$\square$ Non~\squareChecked<?php endif;?> \\
\hspace*{0.5cm}
Observations : \CONTRATOBSERVATIONS \\
  ~ \\   ~ \\
%PARTIE 7%
\circled{7}~~\textbf{Enregistrement à l'IVBD:}\\
\hspace*{0.5cm}
En vertu de l'article 4 des Accords Interprofessionnels étendus de l'IVBD conclus pour la première fois le 21 août 1981, le présent contrat\\
\hspace*{0.5cm}
est soumis à enregistrement auprès des services de l'IVBD. Pour toute annulation conjointe du présent contrat, chaque partie devra manifester\\
\hspace*{0.5cm}
son accord écrit à l'IVBD par la remise de son exemplaire (ou à défaut par courrier signé). Le courtier signataire du présent contrat pouvant\\
\hspace*{0.5cm}
agir au nom de chacune des parties. En cas d'annulation du contrat pour cause de non retiraison du vin dans les délais prévus, le vendeur devra\\
\hspace*{0.5cm}
en avertir l'IVBD par courrier signé et circonstancié.\\
\hspace*{0.5cm}
\textit{Les signataires attestent avoir pris connaissance du verso du présent bordereau, et s'engagent à respecter les conditions particulières et règles}\\
\hspace*{0.5cm}
\textit{d'utilisation spécifiées. En l'absence de signature du vendeur et de l'acheteur, le courtier signataire du présent contrat garantit l'exactitude de}\\
\hspace*{0.5cm}
\textit{l'ensemble des informations portées sur ce document}.

\vspace*{0.3cm}

\begin{minipage}[t]{0.3\textwidth}
<?php if ($vrac->mandataire_identifiant): ?>
\begin{center}
Le Courtier,\\
Signé électroniquement, le <?php echo format_date($vrac->date_signature) ?>
\end{center}
<?php else: ?>
~ \\
<?php endif; ?>
\end{minipage}
\begin{minipage}[t]{0.3\textwidth}
\begin{center}
Le Vendeur,\\
Signé électroniquement, le <?php echo format_date($vrac->date_signature) ?>
\end{center}
\end{minipage}
\begin{minipage}[t]{0.3\textwidth}
\begin{center}
L'Acheteur,\\
Signé électroniquement, le <?php echo format_date($vrac->date_signature) ?>
\end{center}
\end{minipage}

\newpage

\includegraphics[scale=0.95]{<?php echo sfConfig::get('sf_web_dir'); ?>/pdf/_annexe_raisin.pdf}

\end{document}
