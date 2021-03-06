<?php use_helper('DRM'); ?>
<div id="forms_errors" style="color: red;">
    <?php include_partial('drm_edition/itemFormErrors', array('form' => $form)) ?>
</div>

<div id="colonnes_dr" class="row">
    <?php
    include_partial('drm_edition/itemHeader', array('config' => $config,
        'drm' => $drm,
        'etablissement' => $etablissement,
        'favoris' => $favoris,
        'formFavoris' => $formFavoris,
        'isTeledeclarationMode' => $isTeledeclarationMode,
        'detailsNodes' => $detailsNodes,
        'detail' => $detail,
        'saisieSuspendu' => $saisieSuspendu));
    ?>
        <div id="col_saisies" class="col-xs-8 well" style="overflow-x: auto; position: relative;" >

            <script type="text/javascript">
                /* Colonne avec le focus par défaut */
                var colFocusDefaut = <?php echo getNumberOfFirstProduitWithMovements($produits); if(is_null(getNumberOfFirstProduitWithMovements($produits))): echo '""'; endif; ?>;

            </script>
            <div style="float: left;" id="col_saisies_cont" class="section_label_maj">
            <?php $first = true;
            $cpt = 1;
            ?>
            <?php foreach ($produits as $key => $produit): ?>
                <?php if(!$produit->hasMovements()): continue; endif; ?>
                <?php
                include_component('drm_edition', 'itemForm', array(
                    'config' => $config,
                    'etablissement' => $etablissement,
                    'detail' => $produit,
                    'detailsKey' => $detailsKey,
                    'active' => ($detail && $detail->getHash() == $produit->getHash()),
                    'numProduit' => $cpt,
                    'form' => $form,
                    'favoris' => $favoris,
                    'isTeledeclarationMode' => $isTeledeclarationMode,
                    'saisieSuspendu' => $saisieSuspendu));
                $cpt++;
                ?>
                <?php $first = $first && !$produit->hasMovements(); ?>
            <?php endforeach; ?>
            <div class="clearfix"></div>
            </div>
        </div>
        <div class="clearfix"></div>
</div>
