<?php
setlocale(LC_TIME, 'fr_FR');
$items = explode(PHP_EOL, $csv);
array_shift($items);
$maxTableRowsPerPage = 30;
$nbPage = 0;
$options = $options->getRawValue();
$periode = (isset($options['periode']) && isset($options['periode'][0]) && isset($options['periode'][1]))? $options['periode'] : null;
$compare = (isset($options['compare']))? $options['compare'] : false;
$appellations = (isset($options['appellations']))? $options['appellations'] : array();
?>
\documentclass[a4paper, landscape, 10pt]{article}
\usepackage[utf8]{inputenc}
\usepackage[top=2.3cm, bottom=1.8cm, left=0.5cm, right=0.5cm, headheight=2cm, headsep=0.5cm, marginparwidth=0cm]{geometry}
\usepackage{fancyhdr}
\usepackage{graphicx}
\usepackage{multicol}
\usepackage{colortbl}
\usepackage{tabularx}
\usepackage{multirow}
\usepackage[framemethod=tikz]{mdframed}
\usepackage{lastpage}

\def\LOGO{<?php echo sfConfig::get('sf_web_dir'); ?>/images/logo_bivc.png}
\renewcommand{\arraystretch}{1.2}
\makeatletter
\setlength{\@fptop}{5pt}
\makeatother


\fancyhf{}
\renewcommand{\headrulewidth}{0cm}
\renewcommand\sfdefault{phv}
\renewcommand{\familydefault}{\sfdefault}
\fancyfoot[R]{\thepage~/~\pageref{LastPage}}
\fancyfoot[L]{<?php echo strftime("%e %B %Y", time()) ?>}
\fancyhead[L]{\includegraphics[scale=0.6]{\LOGO}}
\fancypagestyle{fstyle_0}{
\fancyhead[C]{Volume exporté par pays et par couleur pour <?php if (count($appellations) > 1): ?>les appellations : \\ \textbf{<?php echo implode(', ', $appellations); ?>}<?php elseif (count($appellations) > 0): ?>l'appellation \textbf{<?php echo $appellations[0]; ?>}<?php else: ?>les vins du \textbf{Centre-Loire}<?php endif; ?><?php if ($periode): ?>\\Période du \textbf{<?php echo $periode[0] ?>} au \textbf{<?php echo $periode[1] ?>}<?php endif; ?>}
}

\begin{document}


\pagestyle{fstyle_0}

\begin{table}[ht!]
<?php if ($compare): ?>
\begin{tabularx}{\linewidth}{ | X | >{\raggedleft}p{0.061\linewidth} | >{\raggedleft}p{0.061\linewidth} | >{\raggedleft}p{0.028\linewidth} | >{\raggedleft}p{0.061\linewidth} | >{\raggedleft}p{0.061\linewidth} | >{\raggedleft}p{0.028\linewidth} | >{\raggedleft}p{0.061\linewidth} | >{\raggedleft}p{0.061\linewidth} | >{\raggedleft}p{0.028\linewidth} | >{\raggedleft}p{0.061\linewidth} | >{\raggedleft}p{0.061\linewidth} | >{\raggedleft}p{0.028\linewidth} | }
\hline
\rowcolor{gray!40} & \multicolumn{3}{c |}{Blanc} & \multicolumn{3}{c |}{Rosé} & \multicolumn{3}{c |}{Rouge} & \multicolumn{3}{c |}{Total} \tabularnewline
\rowcolor{gray!40} Pays & \multicolumn{1}{c |}{N-1} & \multicolumn{1}{c |}{N} & \multicolumn{1}{c |}{\%} & \multicolumn{1}{c |}{N-1} & \multicolumn{1}{c |}{N} & \multicolumn{1}{c |}{\%} & \multicolumn{1}{c |}{N-1} & \multicolumn{1}{c |}{N} & \multicolumn{1}{c |}{\%} & \multicolumn{1}{c |}{N-1} & \multicolumn{1}{c |}{N} & \multicolumn{1}{c |}{\%} \tabularnewline \hline
<?php else: ?>
\begin{tabularx}{\linewidth}{ | X | >{\raggedleft}p{0.1\linewidth} | >{\raggedleft}p{0.1\linewidth} | >{\raggedleft}p{0.1\linewidth} | >{\raggedleft}p{0.1\linewidth} | }
\hline
\rowcolor{gray!40} Pays & \multicolumn{1}{c |}{Blanc} & \multicolumn{1}{c |}{Rosé} & \multicolumn{1}{c |}{Rouge} & \multicolumn{1}{c |}{Total} \tabularnewline \hline
<?php endif; ?>
<?php 
	$i = ($compare)? 2 : 1;
	foreach ($items as $item):
		$values = explode(';', $item);
		if (!$values[0]) {
			continue;
		}
		$isTotal = preg_match('/total/i', $item);
		$current = $values[0];
?>
<?php if ($i == $maxTableRowsPerPage): ?>
\end{tabularx}
\end{table}
\clearpage
\pagestyle{fstyle_0}
\begin{table}[ht!]
<?php if ($compare): ?>
\begin{tabularx}{\linewidth}{ | X | >{\raggedleft}p{0.061\linewidth} | >{\raggedleft}p{0.061\linewidth} | >{\raggedleft}p{0.028\linewidth} | >{\raggedleft}p{0.061\linewidth} | >{\raggedleft}p{0.061\linewidth} | >{\raggedleft}p{0.028\linewidth} | >{\raggedleft}p{0.061\linewidth} | >{\raggedleft}p{0.061\linewidth} | >{\raggedleft}p{0.028\linewidth} | >{\raggedleft}p{0.061\linewidth} | >{\raggedleft}p{0.061\linewidth} | >{\raggedleft}p{0.028\linewidth} | }
<?php else: ?>
\begin{tabularx}{\linewidth}{ | X | >{\raggedleft}p{0.1\linewidth} | >{\raggedleft}p{0.1\linewidth} | >{\raggedleft}p{0.1\linewidth} | >{\raggedleft}p{0.1\linewidth} | }
<?php endif; ?>
\hline
<?php $i=0; else: $i++; endif; ?>
<?php if (preg_match('/total/i', $current)): ?>\hline<?php endif; ?><?php if ($isTotal): ?>\rowcolor{gray!40} <?php endif; if (preg_match('/total/i', $current)) {unset($values[0]); echo 'TOTAL général & '; } echo implode(' & ', $values); ?> \tabularnewline \hline
<?php  endforeach;?>
\end{tabularx}
\end{table}

\end{document} 