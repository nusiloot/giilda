<?php
use_helper('BivcStatistique');

if ($lastPeriode) {
	$csv = "Pays;Blanc N-1;Blanc;Blanc %;Rosé N-1;Rosé;Rosé %;Rouge N-1;Rouge;Rouge %;TOTAL N-1;TOTAL;TOTAL %\n";
	$result = $result->getRawValue();
	$lastPeriode = $lastPeriode->getRawValue();
	$resultKeys = array_keys($result);
	$resultPartKeys = array();
	foreach ($result as $key => $values) {
		$key = sfOutputEscaper::unescape($key);
		$tabKey = explode('/', $key);
		if (!in_array($tabKey[0], $resultPartKeys)) {
			$resultPartKeys[] = $tabKey[0];
		}
		if ($tabKey[0] == 'TOTAL') {
			foreach ($lastPeriode as $subkey => $subvalues) {
				$subtabKey = explode('/', $subkey);
				if (!in_array($subtabKey[0], $resultPartKeys)) {
					$csv .= $subtabKey[0].';'.$subvalues[0].';'.null.';'.getEvol($subvalues[0], 0).';'.$subvalues[1].';'.null.';'.getEvol($subvalues[1], 0).';'.$subvalues[2].';'.null.';'.getEvol($subvalues[2], 0).';'.$subvalues[3].';'.null.';'.getEvol($subvalues[3], 0)."\n";
				}
			}
		}
		if (isset($lastPeriode[$key])) {
			$csv .= $tabKey[0].';'.$lastPeriode[$key][0].';'.$values[0].';'.getEvol($lastPeriode[$key][0], $values[0]).';'.$lastPeriode[$key][1].';'.$values[1].';'.getEvol($lastPeriode[$key][1], $values[1]).';'.$lastPeriode[$key][2].';'.$values[2].';'.getEvol($lastPeriode[$key][2], $values[2]).';'.$lastPeriode[$key][3].';'.$values[3].';'.getEvol($lastPeriode[$key][3], $values[3])."\n";
		} else {
			$csv .= $tabKey[0].';'.null.';'.$values[0].';'.getEvol(0, $values[0]).';'.null.';'.$values[1].';'.getEvol(0, $values[1]).';'.null.';'.$values[2].';'.getEvol(0, $values[2]).';'.null.';'.$values[3].';'.getEvol(0, $values[3])."\n";
		}
	}
} else {
	$csv = "Pays;Blanc;Rosé;Rouge;TOTAL\n";
	$totalBlanc = ($result['totaux_blanc']['value'] != 0)? formatNumber($result['totaux_blanc']['value'],2) : null;
	$totalRose = ($result['totaux_rose']['value'] != 0)? formatNumber($result['totaux_rose']['value'],2) : null;
	$totalRouge = ($result['totaux_rouge']['value'] != 0)? formatNumber($result['totaux_rouge']['value'],2) : null;
	$totalTotal = ($result['totaux_total']['value'] != 0)? formatNumber($result['totaux_total']['value'],2) : null;
	foreach ($result['agg_line']['buckets'] as $pays) {
		$paysLibelle = $pays['key'];
		$blanc = ($pays['blanc']['agg_column']['value'] != 0)? formatNumber($pays['blanc']['agg_column']['value'],2) : null;
		$rose = ($pays['rose']['agg_column']['value'] != 0)? formatNumber($pays['rose']['agg_column']['value'],2) : null;
		$rouge = ($pays['rouge']['agg_column']['value'] != 0)? formatNumber($pays['rouge']['agg_column']['value'],2) : null;
		$total = ($pays['total']['agg_column']['value'] != 0)? formatNumber($pays['total']['agg_column']['value'],2) : null;
		$csv .= $paysLibelle.';'.$blanc.';'.$rose.';'.$rouge.';'.$total."\n";
	}
	$csv .= 'TOTAL;'.$totalBlanc.';'.$totalRose.';'.$totalRouge.';'.$totalTotal."\n";
}
echo $csv;
