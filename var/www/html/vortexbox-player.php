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

function NotMac($address){
If(strlen($address) > 17) return 1;
If($address == "") return 1;
If (!eregi("^[0-9A-Z]+(\:[0-9A-Z]+)+(\:[0-9A-Z]+)+(\:[0-9A-Z]+)+(\:[0-9A-Z]+)+(\:[0-9A-Z]+)$",$address)) return 1;
$Array=explode(":",$address);
If(strlen($Array[0]) != 2) return 1;
If(strlen($Array[1]) != 2) return 1;
If(strlen($Array[2]) != 2) return 1;
If(strlen($Array[3]) != 2) return 1;
If(strlen($Array[4]) != 2) return 1;
If(strlen($Array[5]) != 2) return 1;
return 0;
}

function RandomMac(){
$RandomMac ="00:04:20:".strtoupper(dechex(rand( 0,255))).":".strtoupper(dechex(rand( 0,255))).":".strtoupper(dechex(rand( 0,255)));
return $RandomMac;
}

$smarty = new Smarty;
$smarty->caching = 0;

$smarty->compile_check = true;
$smarty->debugging = false;

$configfile = "/var/www/html/config/playergui.cfg";

require '/var/www/html/libs/vortexbox_defs.php';
require '/var/www/html/libs/vortexbox_smarty.php';

$_action = isset($_REQUEST['action']) ? $_REQUEST['action'] : 'default';
$config = array();

if (file_exists($configfile)) {
    $config = array();
} else {
// build default if required
    $config = array( 0 => array ( "DEVICENAME" => "Default", "NAME" => "VortexBox Player", "MAC" => RandomMac(), "softvol_ischecked" => "no" ),
	1 => array ("softvol_ischecked" => "no" ),
	2 => array ("softvol_ischecked" => "no" ),
	3 => array ("softvol_ischecked" => "no" ),
	4 => array ("softvol_ischecked" => "no" ),
	);
	$fp = fopen($configfile,'w');
	fwrite($fp,serialize($config));
	fclose($fp);	
}
	
switch($_action) {

    case 'submit':
	
		for ( $counter = 0; $counter <= 4 ; $counter++) {
		  if (isset($_REQUEST['DEVICENAME'.$counter]) & !$_REQUEST['DEVICENAME'.$counter] =="") { $config[$counter]['DEVICENAME'] = $_REQUEST['DEVICENAME'.$counter]; }
		  if (isset($_REQUEST['NAME'.$counter]) & !$_REQUEST['NAME'.$counter] =="") { $config[$counter]['NAME'] = $_REQUEST['NAME'.$counter]; }
		  if (isset($_REQUEST['MAC'.$counter]) & !$_REQUEST['MAC'.$counter] =="") { $config[$counter]['MAC'] = strtoupper($_REQUEST['MAC'.$counter]); }
		  if (isset($config[$counter]['NAME']) & isset($_REQUEST['SOFTVOL'.$counter]) & !$_REQUEST['SOFTVOL'.$counter] =="") 
		  { $config[$counter]['softvol_ischecked'] = $_REQUEST['SOFTVOL'.$counter][0]; } else {$config[$counter]['softvol_ischecked'] = "no";}
		  
		  if (isset($config[$counter]['NAME']) & !isset($config[$counter]['MAC'])) {$config[$counter]['MAC'] = RandomMac(); }
		  if (isset($config[$counter]['MAC']) & NotMac($config[$counter]['MAC'])) {$config[$counter]['MAC'] = RandomMac(); }
		}  
		$fp = fopen($configfile,'w');
		fwrite($fp,serialize($config));
		fclose($fp);
//restart vortexbox-player
		exec("sudo /opt/vortexbox/doaction.sh RestartVBplayer & >/dev/null 2>&1");		
	
		break;   
	default:
		$configall = file_get_contents($configfile);
		$config = unserialize($configall); 
}

$x=0;
foreach ($config as $devarray) {
  foreach ($devarray as $key => $value) {
   $smarty->assign($key.$x,$value);
  }
$x++;
}

$smarty->assign('softvol_checkbox', array(
					'softvol' => '',
                     ));

$smarty->assign('CardList', file_get_contents('/proc/asound/cards'));
$smarty->assign('CardOutputList', file_get_contents('/proc/asound/devices'));

$smarty->display('vortexbox-player.tpl');

?>
