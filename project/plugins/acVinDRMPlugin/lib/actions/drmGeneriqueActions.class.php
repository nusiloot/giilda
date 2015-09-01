<?php

/**
 * Description of class drmGeneriqueActions
 * @author mathurin
 */
class drmGeneriqueActions extends sfActions {

    protected function initSocieteAndEtablissementPrincipal() {
        $this->compte = $this->getUser()->getCompte();
        if ($this->isTeledeclarationDrm()) {

            if (!$this->compte) {
                new sfException("Le compte $compte n'existe pas");
            }
            $this->societe = $this->compte->getSociete();
            $this->etablissementPrincipal = $this->societe->getEtablissementPrincipal();
        }
    }

    protected function redirect403IfIsNotTeledeclaration() {
        if (!$this->isTeledeclarationDrm()) {
            $this->redirect403();
        }
    }
    
     protected function redirect403IfIsTeledeclaration() {
        if ($this->isTeledeclarationDrm()) {
            $this->redirect403();
        }
    }

    protected function redirect403IfIsNotTeledeclarationAndNotMe() {
        $this->redirect403IfIsNotTeledeclaration();
        if ($this->getUser()->getCompte()->identifiant != $this->identifiant) {
            $this->redirect403();
        }
    }

    private function redirect403() {
        $this->forward(sfConfig::get('sf_secure_module'), sfConfig::get('sf_secure_action'));
    }

    protected function isTeledeclarationDrm() {
        return $this->getUser()->hasTeledeclarationDrm();
    }
    
    protected function initDeleteForm() {
        $this->deleteForm = new DRMDeleteForm($this->drm);
    }
    
    protected function isUsurpationMode() {
        return $this->getUser()->isUsurpationCompte();
    }

}
