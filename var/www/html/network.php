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

switch($_action) {

    case 'submit':

	// check to see if user wants Sonos shares
	if (isset($_REQUEST['SONOS'][0]) & !$_REQUEST['SONOS'][0] =="") {
		exec("touch /etc/vortexbox/sonos.smb");
	} else {
		exec("rm /etc/vortexbox/sonos.smb");
	}
		
	$lines = file($networkConfigFile);
	$config = array();
 
	foreach ($lines as $line_num=>$line) {
		if ( ! preg_match("/#.*/", $line) ) {
		# Contains non-whitespace?
		if ( preg_match("/\S/", $line) ) {
		list( $key, $value ) = explode( "=", trim( $line ), 2);
		$config[$key] = $value;
		}
	  }
	}

	if (isset($_REQUEST['WORKGROUP']) & !$_REQUEST['WORKGROUP'] =="") { $WORKGROUP = $_REQUEST['WORKGROUP']; }
	if (isset($_REQUEST['SYSNAME']) & !$_REQUEST['SYSNAME'] =="") { $SYSNAME = $_REQUEST['SYSNAME']; }
	$smarty->assign('WORKGROUP', $WORKGROUP);
	$smarty->assign('SYSNAME', strtolower($SYSNAME));
	
	
	if (isset($_REQUEST['BOOTPROTO']) & !$_REQUEST['BOOTPROTO'] =="") { $config['BOOTPROTO'] = $_REQUEST['BOOTPROTO']; }
	if (isset($_REQUEST['IPADDR']) & !$_REQUEST['IPADDR'] =="") { $config['IPADDR'] = $_REQUEST['IPADDR']; }
	if (isset($_REQUEST['NETMASK']) & !$_REQUEST['NETMASK'] =="") { $config['NETMASK'] = $_REQUEST['NETMASK']; }
	if (isset($_REQUEST['GATEWAY']) & !$_REQUEST['GATEWAY'] =="") { $config['GATEWAY'] = $_REQUEST['GATEWAY']; }
	if (isset($_REQUEST['DNS1']) & !$_REQUEST['DNS1'] =="") { $config['DNS1'] = $_REQUEST['DNS1']; }
	if (isset($_REQUEST['DNS2']) & !$_REQUEST['DNS2'] =="") { $config['DNS2'] = $_REQUEST['DNS2']; }
	if (isset($_REQUEST['DNS3']) & !$_REQUEST['DNS3'] =="") { $config['DNS3'] = $_REQUEST['DNS3']; }

	if (isset($_REQUEST['DNS1']) & $_REQUEST['DNS1'] =="") { 
		$config['DNS1'] = "208.67.222.222";
		$config['DNS2'] = "208.67.220.220";
	}
	// Make sure we have a hardware address
	if (empty($config['HWADDR'])) { $config['HWADDR'] = exec("/bin/cat /sys/class/net/eth0/address"); }	
	
	// Make sure we have all the info we need for stat IP 
	if (empty($config['IPADDR']) || empty($config['NETMASK']) || empty($config['GATEWAY']) || empty($config['DNS1'])) {
		$config['BOOTPROTO'] = "dhcp";
	}

	if ($fp = fopen($tempfile, 'w')) {
	fwrite($fp, "# Created by VortexBox web admin on ".$dateTimeNow."\n");
	  if ($config['BOOTPROTO'] == "none") {
		fwrite($fp, "DEVICE=eth0\n");
		fwrite($fp, "HWADDR=".$config['HWADDR']."\n");
		fwrite($fp, "BOOTPROTO=none\n");		
		fwrite($fp, "ONBOOT=yes\n");
		fwrite($fp, "NM_CONTROLLED=yes\n");
		fwrite($fp, "IPADDR=".$config['IPADDR']."\n");
		fwrite($fp, "NETMASK=".$config['NETMASK']."\n");
		fwrite($fp, "GATEWAY=".$config['GATEWAY']."\n");
		fwrite($fp, "DNS1=".$config['DNS1']."\n");	
		if (isset($config['DNS2'])) { fwrite($fp, "DNS2=".$config['DNS2']."\n"); }
		if (isset($config['DNS3'])) { fwrite($fp, "DNS3=".$config['DNS3']."\n"); }	

	  } else {
		fwrite($fp, "DEVICE=eth0\n");
		fwrite($fp, "HWADDR=".$config['HWADDR']."\n");
		fwrite($fp, "BOOTPROTO=dhcp\n");		
		fwrite($fp, "ONBOOT=yes\n");
		fwrite($fp, "NM_CONTROLLED=yes\n");
	  }

	} else {
		echo 'Config file unwritable... '; 
	}
	
	exec("sudo /opt/vortexbox/setup_network.sh $SYSNAME $WORKGROUP & >/dev/null 2>&1");
	
        break;
    default:
	
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

	$smarty->assign('WORKGROUP', $smblines['workgroup']);
	$smarty->assign('SYSNAME', strtolower($smblines['netbios name']));

        break;   
}

$lines = file($networkConfigFile);
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

if ($config['BOOTPROTO'] == "") 
{
$config['BOOTPROTO'] = "dhcp";
$smarty->assign('BOOTPROTO', "dhcp"); 
}

$smarty->assign('iptype_name', array(
					'dhcp' => 'DHCP',
					'none' => 'Static IP address'
                     ));

$smarty->assign('sonos_checkbox', array(
					'sonos' => 'Enable',
                     ));

if (file_exists("/etc/vortexbox/sonos.smb")) {
    $smarty->assign('sonos_ischecked', "sonos");
} else {
   $smarty->assign('sonos_ischecked', "no");
}

$smarty->display('network.tpl');
?>
