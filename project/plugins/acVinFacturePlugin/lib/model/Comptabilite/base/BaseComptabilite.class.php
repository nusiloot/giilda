<?php
/**
 * BaseComptabilite
 * 
 * Base model for Comptabilite
 *
 * @property string $_id
 * @property string $_rev
 * @property string $type
 * @property acCouchdbJson $identifiants_analytiques

 * @method string get_id()
 * @method string set_id()
 * @method string get_rev()
 * @method string set_rev()
 * @method string getType()
 * @method string setType()
 * @method acCouchdbJson getIdentifiantsAnalytiques()
 * @method acCouchdbJson setIdentifiantsAnalytiques()
 
 */
 
abstract class BaseComptabilite extends acCouchdbDocument {

    public function getDocumentDefinitionModel() {
        return 'Comptabilite';
    }
    
}