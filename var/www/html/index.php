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

$macaddress=exec("/sbin/ifconfig | grep -m 1 HWaddr | awk -F 'HWaddr ' '{ print $2 }'");
$fedora_version=exec("/bin/cat /etc/fedora-release");
// check RAID status
$RAIDstatus = exec("sudo /opt/vortexbox/doaction.sh RAIDstatus");

$smarty = new Smarty;
$smarty->caching = 0;

$smarty->compile_check = true;
$smarty->debugging = false;

require '/var/www/html/libs/vortexbox_defs.php';
require '/var/www/html/libs/vortexbox_smarty.php';

$lines = file($smbfile);
$smblines = array();
foreach ($lines as $line_num=>$line) {
		if ( ! preg_match("/#.*/", $line) ) {
		# Contains non-whitespace?
		if ( preg_match("/\S/", $line) ) {
		list( $key, $value ) = explode( "=", trim( $line ), 2);
		$smblines[trim($key)] = trim($value);
		}
	  }
}
$smarty->assign('SYSNAME', strtolower($smblines['netbios name']));

$storageinfo = explode(" ",StripExtraSpace(exec("df -h --total /storage | grep total")));
$smarty->assign('STORAGESIZE', $storageinfo[1]);
$smarty->assign('STORAGEUSED', $storageinfo[2]);
$smarty->assign('STORAGEAVAIL', $storageinfo[3]);
$smarty->assign('STORAGEPERCENT', $storageinfo[4]);

$smarty->assign('FEDORAVER', $fedora_version);
$smarty->assign('IPADDRESS', $ipaddress);
$smarty->assign('MACADDRESS', $macaddress);
$smarty->assign('NIC', $nic);
$smarty->assign('VORTEXBOXVERSION', $VortexBoxVersion);

$smarty->assign('RAIDSTATUS', $RAIDstatus);

$smarty->display('index.tpl');

?>
