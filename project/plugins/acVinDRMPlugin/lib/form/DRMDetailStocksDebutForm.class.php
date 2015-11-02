<?php

class DRMDetailStocksDebutForm  extends acCouchdbObjectForm {

    public function configure() {
    	$configurationDetail = $this->getObject()->getParent()->getConfig();
    	foreach ($configurationDetail->getStocksDebut() as $key => $value) {
    		if ($value->readable) {
	    		if (!$value->writable || !$this->getObject()->getParent()->canSetStockDebutMois()) {
	    			$this->setWidget($key, new bsWidgetFormInputFloat(array('decimal' => 4), array('readonly' => 'readonly')));
	    		} else {
	    			$this->setWidget($key, new bsWidgetFormInputFloat(array('decimal' => 4)));
	    		}
	    		$this->setValidator($key, new sfValidatorNumber(array('required' => false)));
    		}
    	}        
        $this->widgetSchema->setNameFormat('drm_detail_stocks_debut[%s]');
        $this->errorSchema = new sfValidatorErrorSchema($this->validatorSchema);
    }

}