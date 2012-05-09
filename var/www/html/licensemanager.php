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

exec("sudo /opt/vortexbox/doaction.sh GetMKVconfig >/dev/null 2>&1");

$config = parse_ini_file("/tmp/settings.conf");

switch($_action) {
    case 'submit':
		if (isset($_REQUEST['MAKEMKVLICENSE']) & !$_REQUEST['MAKEMKVLICENSE'] =="") { 
			$config['app_Key'] = $_REQUEST['MAKEMKVLICENSE']; 
		} else {
			unset($config["app_Key"]);
		}

		if($file = fopen("/tmp/settings.conf", "w"));
		foreach ($config as $key => $value)
		{
			fwrite($file, $key ." = ".'"'.$value.'"'."\n");
		}
		fclose($file);
		exec("sudo /opt/vortexbox/doaction.sh PutMKVconfig >/dev/null 2>&1");
	
		break;

	default:
}

if (isset($config["app_Key"])) {  
	$MakemkvLicense = $config["app_Key"];
} else {
	$MakemkvLicense = "";
}

$smarty->assign('MAKEMKVLICENSE', $MakemkvLicense);
$smarty->display('licensemanager.tpl');

?>
