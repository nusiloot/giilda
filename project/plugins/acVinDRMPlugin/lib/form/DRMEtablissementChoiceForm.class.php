<?php

class DRMEtablissementChoiceForm extends EtablissementChoiceForm {

    public function configure()
    {
        parent::configure();
        $this->configureFamilles(array(EtablissementFamilles::FAMILLE_PRODUCTEUR, SocieteClient::SUB_TYPE_VITICULTEUR));
    }

}

