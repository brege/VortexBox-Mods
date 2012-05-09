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

require '/var/www/html/libs/vortexbox_defs.php';
require '/var/www/html/libs/vortexbox_smarty.php';

$_action = isset($_REQUEST['action']) ? $_REQUEST['action'] : 'default';

if (file_exists($SimplifyMediaConfig)) {

	$lines = file($SimplifyMediaConfig);
	$config = array();
 
	foreach ($lines as $line_num=>$line) {
		if ( ! preg_match("/#.*/", $line) ) {
		# Contains non-whitespace?
		if ( preg_match("/\S/", $line) ) {
		list( $key, $value ) = explode( "=", trim( $line ), 2);
		$config[$key] = $value;
		$smarty->assign($key, $config[$key]); 
		}
	  }
	}

	$SCREENNAME = $config["SCREENNAME"];
	$PASSWORD = $config["PASSWORD"];
	$LOCATION = $config["LOCATION"];
} else {
	$SCREENNAME = "";
	$PASSWORD = "";
	$LOCATION = "VortexBox";
}

switch($_action) {

    case 'submit':
	if (isset($_REQUEST['SCREENNAME']) & !$_REQUEST['SCREENNAME'] =="") { $SCREENNAME = $_REQUEST['SCREENNAME']; }
	if (isset($_REQUEST['PASSWORD']) & !$_REQUEST['PASSWORD'] =="") { $PASSWORD = $_REQUEST['PASSWORD']; }
	if (isset($_REQUEST['LOCATION']) & !$_REQUEST['LOCATION'] =="") { $LOCATION = $_REQUEST['LOCATION']; }
	
	// make sure the user enters a valid location
	$badchar = array("&", "/", "'", ":", "<", ">", "@", " ");
	$LOCATION = str_replace($badchar, "_", substr($LOCATION, 0, 32));
	
	if ($fp = fopen($SimplifyMediaConfig, 'w')) {
		fwrite($fp, "SCREENNAME=".$SCREENNAME."\n");
		fwrite($fp, "PASSWORD=".$PASSWORD."\n");
		fwrite($fp, "LOCATION=".$LOCATION."\n");
		fclose($fp); 
	} else {
		echo 'Config file unwritable... '; 
	}
	
	exec("sudo /opt/vortexbox/doaction.sh SimplifyMedia & >/dev/null 2>&1");	
	
        break;
    default:
	
        break;
}

$smarty->assign('SCREENNAME', $SCREENNAME);
$smarty->assign('PASSWORD', $PASSWORD);
$smarty->assign('LOCATION', $LOCATION);


$smarty->display('simplifymedia.tpl');

?>
