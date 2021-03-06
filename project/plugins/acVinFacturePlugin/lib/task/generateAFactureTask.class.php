<?php

class generateAFactureTask extends sfBaseTask
{
  protected function configure()
  {
    // // add your own arguments here
    $this->addArguments(array(
			    new sfCommandArgument('factureid', null, sfCommandOption::PARAMETER_REQUIRED, 'Facture id'),
    ));

    $this->addOptions(array(
			    new sfCommandOption('application', null, sfCommandOption::PARAMETER_REQUIRED, 'The application name', 'giilde'),
			    new sfCommandOption('env', null, sfCommandOption::PARAMETER_REQUIRED, 'The environment', 'prod'),
			    new sfCommandOption('connection', null, sfCommandOption::PARAMETER_REQUIRED, 'The connection name', 'default'),
			    new sfCommandOption('directory', null, sfCommandOption::PARAMETER_REQUIRED, 'Output directory', '.'),
      // add your own options here
    ));

    $this->namespace        = 'generate';
    $this->name             = 'AFacture';
    $this->briefDescription = '';
    $this->detailedDescription = <<<EOF
The [generatePDF|INFO] task does things.
Call it with:

  [php symfony generatePDF|INFO]
EOF;
  }
  
  protected function execute($arguments = array(), $options = array())
  {
    sfContext::createInstance($this->configuration);
    // initialize the database connection
    $databaseManager = new sfDatabaseManager($this->configuration);
    $connection = $databaseManager->getDatabase($options['connection'])->getConnection();
    $facture = FactureClient::getInstance()->find($arguments['factureid']);
    $latex = new FactureLatex($facture, $this->config);
    $file = $latex->getPDFFile();
    $destdir = $options['directory'].'/'.$latex->getPublicFileName();
    copy($file, $destdir) or die("pb rename $file $destdir");
  }
}
