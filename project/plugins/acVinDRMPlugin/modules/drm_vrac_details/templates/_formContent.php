<?php
echo $form->renderHiddenFields();
echo $form->renderGlobalErrors();
?>
<table id="drm_vrac_details_table" class="table table-striped">
    <thead>
        <tr>
            <th class="<?php if($isTeledeclarationMode): ?>col-xs-4<?php else: ?>col-xs-7<?php endif; ?>">Numéro contrat</th>
            <th class="<?php if($isTeledeclarationMode): ?>col-xs-3<?php else: ?>col-xs-4<?php endif; ?>">Volumes</th>
            <?php if($isTeledeclarationMode): ?>
            <th class="col-xs-2">Type de doc</th>
            <th class="col-xs-2">Numéro&nbsp;de&nbsp;document</th>  
            <?php endif; ?>
            <th class="col-xs-1"></th>
        </tr>
    </thead>
    <tbody>
        <?php
        foreach ($form as $itemForm) {
            if ($itemForm instanceof sfFormFieldSchema) {
                include_partial('item', array('form' => $itemForm, 'detail' => $detail, 'isTeledeclarationMode' => $isTeledeclarationMode));
            } else {
                $itemForm->renderRow();
            }
        }
        ?>
    </tbody>
    <tfoot>
        <tr>
            <td></td>
            <td class="lead text-right">
                <div class="input-group">
                    <div class="input-group-addon">&Sigma;</div>
                    <input type="text" class="form-control text-right" readonly="readonly" value="<?php echo $detail->sorties->vrac > 0 ? $detail->sorties->vrac : "0.00" ?>" />
                    <div class="input-group-addon">hl</div>
                </div>
            </td>
            <?php if ($isTeledeclarationMode) : ?>
            <td></td>
            <td></td>
            <?php endif; ?>
            <td class="text-right"><button type="button" data-container="#drm_vrac_details_table tbody" data-template="#template_vrac" class="btn btn-default dynamic-element-add"><span class="glyphicon glyphicon-plus"></span></a></td>
        </tr>
    </tfoot>
</table>
