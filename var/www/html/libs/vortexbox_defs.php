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

$networkConfigFile = "/etc/sysconfig/network-scripts/ifcfg-eth0";
$SimplifyMediaConfig = "/etc/vortexbox/SimplifyMediaConfig.txt";
$lamopt = "/etc/vortexbox/lameopt.txt";
$oggopt = "/etc/vortexbox/oggopt.txt";
$CurrentUsbDriveFile = "/etc/vortexbox/CurrentUsbDrive.txt";
$smbfile = "/etc/samba/smb.conf";
$tempfile = "/var/tmp/ifcfg-eth0.new";
$SYSNAME = "vortexbox";
$WORKGROUP = "WORKGROUP";
$VortexBoxVersion = exec("cat /etc/vortexbox/vortexbox-version");
$dateTimeNow = date("m/d/Y g:i:s A", time());

function StripExtraSpace($s)
{
	for($i = 0; $i < strlen($s); $i++)
	{
	  $newstr = $newstr . substr($s, $i, 1);
	  if(substr($s, $i, 1) == ' ')
	  while(substr($s, $i + 1, 1) == ' ')
	  $i++;
	}
return $newstr;
}

$servicestatus = array (
	"vortexbox" 		=> array ( 	"Name" => "Auto CD Ripper",
									"Status" => "Unknown",
							),
	"forked-daapd" 		=> array ( 	"Name" => "DAAP (iTunes) Server",
									"Status" => "Unknown",
							),
	"minidlna" 			=> array ( 	"Name" => "DLNA Server",
									"Status" => "Unknown",
							),
	"smb"				=> array ( 	"Name" => "Samba Server",
									"Status" => "Unknown",
							),							
	"squeezeboxserver"	=> array ( 	"Name" => "Logitech Media Server",
									"Status" => "Unknown",
							),
	"vortexbox-player"	=> array ( 	"Name" => "VortexBox Player",
									"Status" => "Unknown",
							)							
);

foreach ($servicestatus as $key => $value) {
	$servicestatus[$key]["Status"] = exec("sudo /opt/vortexbox/doaction.sh ServiceStatus ".$key);
}

// Determine MAC address, NIC, and IP address - check for eth0, eth1, and wlan0.

$InterfacesToCheck = array();
exec("ifconfig | grep -E '(eth|wlan|br)' | awk '{print $1}'",$InterfacesToCheck,$ret);
sort($InterfacesToCheck);

foreach ($InterfacesToCheck as $Interface) {
  $InterfaceIPaddress = exec('ifconfig '.$Interface.' | grep "inet addr" | sed "s/^ *inet addr://" | cut -d" " -f1');
  if ($InterfaceIPaddress) {
    $nic = "$Interface";
    $ipaddress = $InterfaceIPaddress;
	break;
  }
}

$macaddress = exec("ifconfig | grep eth0 | awk -F 'HWaddr ' '{ print $2 }'");

$SCport = ":".trim(exec("grep 'httpport:' /var/lib/squeezeboxserver/prefs/server.prefs | tail -1 | /bin/awk '{print $2}'"));

?>
