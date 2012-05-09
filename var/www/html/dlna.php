<?php
// Copyright (C) 2008 - 2012 vortexbox.org
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
require '/var/www/html/libs/Smarty.class.php';

$smarty = new Smarty;
$smarty->caching = 0;

$smarty->compile_check = true;
$smarty->debugging = false;

$configfile = "/var/www/html/config/dlna.cfg";
$deftemplate = "/var/www/html/config/minidlna.conf.template";
$minidlnaconf = "/var/tmp/minidlna.conf";

include '/var/www/html/libs/SearchReplace.php' ;
require '/var/www/html/libs/vortexbox_defs.php';
require '/var/www/html/libs/vortexbox_smarty.php';

$_action = isset($_REQUEST['action']) ? $_REQUEST['action'] : 'default';
$config = array();

if (file_exists($configfile)) {
    $config = array();
} else {
// build default if required
    $config = array( "AUDIOFILES" => "/storage/music/mp3", "VIDEOFILES" => "/storage/movies", "PICTUREFILES" => "/storage/pictures", "DESCRIPTION" => "VortexBox media server" , "ARTSIZE" => "160");

	$fp = fopen($configfile,'w');
	fwrite($fp,serialize($config));
	fclose($fp);	
}
	
switch($_action) {

    case 'submit':

		if (isset($_REQUEST['AUDIOFILES']) & !$_REQUEST['AUDIOFILES'] =="") { $config['AUDIOFILES'] = $_REQUEST['AUDIOFILES']; }
		if (isset($_REQUEST['VIDEOFILES']) & !$_REQUEST['VIDEOFILES'] =="") { $config['VIDEOFILES'] = $_REQUEST['VIDEOFILES']; }
		if (isset($_REQUEST['PICTUREFILES']) & !$_REQUEST['PICTUREFILES'] =="") { $config['PICTUREFILES'] = $_REQUEST['PICTUREFILES']; }
		if (isset($_REQUEST['DESCRIPTION']) & !$_REQUEST['DESCRIPTION'] =="") { $config['DESCRIPTION'] = $_REQUEST['DESCRIPTION']; }
		if (isset($_REQUEST['ARTSIZE']) & !$_REQUEST['ARTSIZE'] =="") { $config['ARTSIZE'] = intval($_REQUEST['ARTSIZE']); }
		if ($config['ARTSIZE'] > 640) {$config['ARTSIZE'] = "640"; }

		$fp = fopen($configfile,'w');
		fwrite($fp,serialize($config));
		fclose($fp);
		
		$files_to_search = array($minidlnaconf);
		$search_string  = array('##AUDIOFILES##', '##VIDEOFILES##', '##PICTUREFILES##','##DESCRIPTION##', '##ARTSIZE##');
		$replace_string = array($config['AUDIOFILES'], $config['VIDEOFILES'], $config['PICTUREFILES'], $config['DESCRIPTION'], $config['ARTSIZE']);
		copy($deftemplate, $minidlnaconf);
 
		$snr = new File_SearchReplace($search_string,
                              $replace_string,
                              $files_to_search,
                              $direc_to_search,
                              true) ;
		$snr->doSearch();
		
		exec("sudo /opt/vortexbox/doaction.sh RestartDLNA & >/dev/null 2>&1");
	
		break;

	case 'RescanDLNA':
		exec("sudo /opt/vortexbox/doaction.sh RescanDLNA & >/dev/null 2>&1");
        break;

	case 'ResetDefaults':
		$config = array( "AUDIOFILES" => "/storage/music/mp3", "VIDEOFILES" => "/storage/movies", "PICTUREFILES" => "/storage/pictures", "DESCRIPTION" => "VortexBox media server", "ARTSIZE" => "160" );
		$fp = fopen($configfile,'w');
		fwrite($fp,serialize($config));
		fclose($fp);
        break;
		
	case 'ClearDLNALog':
		exec("sudo /opt/vortexbox/doaction.sh ClearDLNALog & >/dev/null 2>&1");
        break;		
	
	default:
}

$configall = file_get_contents($configfile);
$config = unserialize($configall); 

foreach ($config as $key => $value) {
   $smarty->assign($key,$value);
}

$smarty->display('dlna.tpl');
?>
