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
// Changelog:
//
// Thurs Jun 23 2011 Ron Olsen <ronolsen@comcast.net>
// * Add RestoreAdd action
// * Based on code from Steve Gray <amawalk@gmail.com>
//
require '/var/www/html/libs/Smarty.class.php';

$smarty = new Smarty;
$smarty->caching = 0;

$smarty->compile_check = true;
$smarty->debugging = false;

require '/var/www/html/libs/vortexbox_defs.php';
require '/var/www/html/libs/vortexbox_smarty.php';

$PrintString = "Please attach your USB drive to your VortexBox. Once your drive is attached you can reload this page by clicking on the backup icon";

$storageinfo = explode(" ",StripExtraSpace(exec("df -h --total /storage | grep total")));
if (file_exists($CurrentUsbDriveFile)) {
  $CurrentUsbDrive=exec("cat ". $CurrentUsbDriveFile);
  $usbinfo = explode(" ",StripExtraSpace(exec("sudo /opt/vortexbox/doaction.sh UsbDiskInfo")));
  $PrintString = "You have attached a ". $usbinfo[2] .$usbinfo[3]." drive and you have ". $storageinfo[2] . " of files to backup.";
  $smarty->assign('CurrentUsbDrive', $CurrentUsbDrive);
  $PrintString .= "<br><br>Click on the Backup icon to update the log display";
}

$_action = isset($_REQUEST['action']) ? $_REQUEST['action'] : 'default';

switch($_action) {
	case 'ClearUsbBackupLog':
		exec("sudo /opt/vortexbox/doaction.sh ClearUsbBackupLog & >/dev/null 2>&1");
                break;
	case 'FormatDrive':
		exec("sudo /opt/vortexbox/doaction.sh FormatDrive & >/dev/null 2>&1");
                break;
	case 'BackupStorage':
		exec("sudo /opt/vortexbox/doaction.sh BackupStorage & >/dev/null 2>&1");
                break;
	case 'StopBackup':
		exec("sudo /opt/vortexbox/doaction.sh StopBackup & >/dev/null 2>&1");
                break;		
	case 'RestoreAdd':
		exec("sudo /opt/vortexbox/doaction.sh RestoreAdd & >/dev/null 2>&1");
                break;		
	
       default:
                break;   
}

$smarty->assign('PrintString', $PrintString );

$smarty->display('backup.tpl');

?>
