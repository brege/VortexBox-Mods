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

$smarty->assign('servicestatus', $servicestatus);

$loacation_count = 0;
$j = 42;

$icon_array[1] = array('location' => $loacation_count += 2*$j+13, 'name' => 'Home', 'icon' => 'home.png', 'link' => '/');
$icon_array[2] = array('location' => $loacation_count += $j, 'name' => 'Logitech Media Server', 'icon' => 'SqueezeCenter.png', 'link' => 'http://'.$ipaddress.$SCport, 'newtab' => '1');

//check to see if ripitis installed
if (file_exists("/usr/bin/ripit")) {
	$icon_array[3] = array('location' => $loacation_count += $j, 'name' => 'CD/DVD Ripping Status', 'icon' => 'cddrive.png', 'link' => '/ripstatus.php');
}	

$icon_array[4] = array('location' => $loacation_count += $j, 'name' => 'Media Mirror', 'icon' => 'flacmirror.png', 'link' => '/flacmirror.php');
$icon_array[5] = array('location' => $loacation_count += $j, 'name' => 'System Info', 'icon' => 'status.png', 'link' => '/phpsysinfo', 'newtab' => '1');
$icon_array[6] = array('location' => $loacation_count += $j, 'name' => 'Network Configuration', 'icon' => 'network.png', 'link' => '/network.php');
$icon_array[7] = array('location' => $loacation_count += $j, 'name' => 'System Configuration', 'icon' => 'tools.png', 'link' => '/system.php');
$icon_array[8] = array('location' => $loacation_count += $j, 'name' => 'Backup', 'icon' => 'backup.png', 'link' => '/backup.php');
$icon_array[9] = array('location' => $loacation_count += $j, 'name' => 'DLNA', 'icon' => 'dlna.png', 'link' => '/dlna.php');

if (file_exists("/var/log/forked-daapd.log")) {
 $icon_array[10] = array('location' => $loacation_count += $j, 'name' => 'DAAP', 'icon' => 'itunes.png', 'link' => '/daap.php');
}  
//check to see if Azureus is installed
if (file_exists("/opt/azureus")) {
	$icon_array[11] = array('location' => $loacation_count += $j, 'name' => 'Azureus BitTorrent', 'icon' => 'frog.png', 'link' => 'http://'.$ipaddress.':6886');
}

if (file_exists("/opt/simplifymedia/SimplifyPeer")) {
	$icon_array[12] = array('location' => $loacation_count += $j, 'name' => 'Simplify Media Server Configuration', 'icon' => 'simplifymedia.png', 'link' => '/simplifymedia.php');
}

if (file_exists("/etc/vortexbox/sonos.smb") && file_exists("/opt/sonos/sonos.pl")) {
	$icon_array[13] = array('location' => $loacation_count += $j, 'name' => 'Sonosweb', 'icon' => 'sonos.png', 'link' => 'http://'.$ipaddress.':8001/isonos');
}

if (file_exists("/lib/systemd/system/transmission-daemon.service")) {
	$icon_array[14] = array('location' => $loacation_count += $j, 'name' => 'Transmission', 'icon' => 'transmission.png', 'link' => 'http://'.$ipaddress.':9091');
}

if (file_exists("/opt/twonkymedia")) {
	$icon_array[15] = array('location' => $loacation_count += $j, 'name' => 'Twonky Media Server Configuration', 'icon' => 'upnp.png', 'link' => 'http://'.$ipaddress.':9001');
}

if (file_exists("/etc/rc.d/init.d/plexmediaserver")) {
	$icon_array[16] = array('location' => $loacation_count += $j, 'name' => 'Plex Media Server Configuration', 'icon' => 'plex.png', 'link' => 'http://'.$ipaddress.':32400/manage');
}

if (file_exists("/opt/MusicMagicMixer/mm.jar")) {
	$icon_array[17] = array('location' => $loacation_count += $j, 'name' => 'MusicIP', 'icon' => 'ams.png', 'link' => 'http://'.$ipaddress.':10002');
}

if (file_exists("/usr/bin/subsonic")) {
	$icon_array[18] = array('location' => $loacation_count += $j, 'name' => 'Subsonic', 'icon' => 'subsonic.png', 'link' => 'http://'.$ipaddress.':4040');
}

if (file_exists("/opt/bliss/bin/bliss.sh")) {
	$icon_array[19] = array('location' => $loacation_count += $j, 'name' => 'Bliss', 'icon' => 'bliss.png', 'link' => 'http://'.$ipaddress.':3220');
}

//check to see if ripit is installed
if (file_exists("/usr/bin/vortexbox-player")) {
	$icon_array[20] = array('location' => $loacation_count += $j, 'name' => 'Configure VortexBox Player', 'icon' => 'vortexbox-player.png', 'link' => '/vortexbox-player.php');
}	

$icon_array[21] = array('location' => $loacation_count += $j, 'name' => 'VortexBox Upgrade', 'icon' => 'upgrade.png', 'link' => '/upgrade.php');

$smarty->assign('IconList',$icon_array);

?>
