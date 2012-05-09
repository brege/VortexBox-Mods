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
$length = isset($_REQUEST['length']) ? $_REQUEST['length'] : '120';

switch($_action) {

    case 'submit':
	$length = (int)$length;
	if ( $length < 120 ) { $length = 120;}
	if ( $length > 14400 ) { $length = 14400;}
	
	if (isset($_REQUEST['LONGER'][0]) & !$_REQUEST['LONGER'][0] =="") {
		exec("echo ".$length." > /etc/vortexbox/ripdvdlength");
	} else {
		exec("rm /etc/vortexbox/ripdvdlength");
	}
	if (isset($_REQUEST['MP4'][0]) & !$_REQUEST['MP4'][0] =="") {
		exec("touch /etc/vortexbox/riptomp4");
	} else {
		exec("rm /etc/vortexbox/riptomp4");
	}
	if (isset($_REQUEST['M2TS'][0]) & !$_REQUEST['M2TS'][0] =="") {
		exec("touch /etc/vortexbox/riptom2ts");
	} else {
		exec("rm /etc/vortexbox/riptom2ts");
	}

        break;	
	case 'RestartRipper':
		exec("sudo /opt/vortexbox/doaction.sh RestartRipper & >/dev/null 2>&1");
        break;
	case 'ClearLog':
		exec("sudo /opt/vortexbox/doaction.sh ClearLog & >/dev/null 2>&1");
        break;
	case 'GetCovers':
		exec("sudo /opt/vortexbox/doaction.sh GetCovers & >/dev/null 2>&1");
        break;		
	case 'CloseTray':
		exec("sudo /opt/vortexbox/doaction.sh CloseTray & >/dev/null 2>&1");
        break;
    default:
        break;   
}

$smarty->assign('longer_checkbox', array(
					'longer' => ' Rip any tracks longer than',
                     ));

if (file_exists("/etc/vortexbox/ripdvdlength")) {
    $smarty->assign('longer_ischecked', "longer");
	$smarty->assign('length', trim(exec("/bin/cat /etc/vortexbox/ripdvdlength")));
} else {
   $smarty->assign('longer_ischecked', "no");
}

$smarty->assign('mp4_checkbox', array(
					'mp4' => ' Mirror tracks to mp4.',
                     ));

if (file_exists("/etc/vortexbox/riptomp4")) {
    $smarty->assign('mp4_ischecked', "mp4");
} else {
   $smarty->assign('mp4_ischecked', "no");
}

$smarty->assign('m2ts_checkbox', array(
					'm2ts' => ' Mirror tracks to m2ts (good for PS3).',
                     ));

if (file_exists("/etc/vortexbox/riptom2ts")) {
    $smarty->assign('m2ts_ischecked', "m2ts");
} else {
   $smarty->assign('m2ts_ischecked', "no");
}

$smarty->display('ripstatus.tpl');

?>
