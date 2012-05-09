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
// Changelog
//
// Thurs Jun 30 2011 Ron Olsen <ronolsen@comcast.net>
// * Add message to Upgrade page to refresh log file display.
//
require '/var/www/html/libs/Smarty.class.php';

$smarty = new Smarty;
$smarty->caching = 0;

$smarty->compile_check = true;
$smarty->debugging = false;

require '/var/www/html/libs/vortexbox_defs.php';
require '/var/www/html/libs/vortexbox_smarty.php';

$packages = array(
	array('name' => 'Bliss', 'shortname' => 'bliss'),
	array('name' => 'Plex Media Server', 'shortname' => 'plex'),
	array('name' => 'Sonos Web', 'shortname' => 'sonosweb'),
	array('name' => 'Subsonic', 'shortname' => 'subsonic'),
	array('name' => 'Transmission BitTorrent client', 'shortname' => 'transmission')
);

for ($i = 0; $i < count($packages); $i++){
  if (file_exists("/etc/vortexbox/packages/".$packages[$i]['shortname'])) {
	$packages[$i]['state'] = "Installed";
  } else {
	$packages[$i]['state'] = "Not Installed";
  }
}

$PrintString .= "Click on 'VortexBox Upgrade' on the left to update the log display.";
$_action = isset($_REQUEST['action']) ? $_REQUEST['action'] : 'default';
$_package = isset($_REQUEST['package']) ? $_REQUEST['package'] : 'default';

for ($i = 0; $i < count($packages); $i++){
  if ($packages[$i]['shortname'] == $_package) {

  $packageaction = $packages[$i]['shortname'];
  } 
}


switch($_action) {
	case 'Upgrade':
		exec("sudo /opt/vortexbox/doaction.sh Upgrade & >/dev/null 2>&1");
        break;
	case 'Install':
		exec("sudo /opt/vortexbox/doaction.sh Install ".$packageaction." & >/dev/null 2>&1");
        break;
	case 'Delete':
		exec("sudo /opt/vortexbox/doaction.sh Delete ".$packageaction." & >/dev/null 2>&1");
        break;		
	case 'ClearUpgradeLog':
		exec("sudo /opt/vortexbox/doaction.sh ClearUpgradeLog & >/dev/null 2>&1");
        break;
    default:
        break;   
}

$smarty->assign('packages', $packages);
$smarty->assign('PrintString', $PrintString );
$smarty->display('upgrade.tpl');

?>
