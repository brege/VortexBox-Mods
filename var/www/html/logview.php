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
$_action = isset($_REQUEST['action']) ? $_REQUEST['action'] : 'default';

switch($_action) {
	case 'riplog':
		echo "<h2>CD Auto Ripper Log</h2>";
		echo "<button onclick='window.location = \"/ripstatus.php\";'>Back</button>";
		echo "<hr><pre>";
		include '/var/log/cdrip.log';
		echo "</pre>";
        break;
	case 'mirrorlog':
		echo "<h2>FLAC Mirror Log</h2>";
		echo "<button onclick='window.location = \"/flacmirror.php\";'>Back</button>";
		echo "<hr><pre>";
		include '/var/log/mirror.log';
		echo "</pre>";
        break;
	case 'upgradelog':
		echo "<h2>Upgrade Log</h2>";
		echo "<button onclick='window.location = \"/upgrade.php\";'>Back</button>";
		echo "<hr><pre>";
		include '/var/log/vbupgrade.log';
		echo "</pre>";
        break;
	case 'usbbackup':
		echo "<h2>USB Backup Log</h2>";
		echo "<button onclick='window.location = \"/backup.php\";'>Back</button>";
		echo "<hr><pre>";
		include '/var/log/usbbackup.log';
		echo "</pre>";
        break;
	case 'SimplifyMedia':
		echo "<h2>Simplify Media Log</h2>";
		echo "<button onclick='window.location = \"/simplifymedia.php\";'>Back</button>";
		echo "<hr><pre>";
		include '/opt/simplifymedia/SimplifyPeer.log';
		echo "</pre>";
        break;
	case 'dlnalog':
		echo "<h2>DLNA Server Log</h2>";
		echo "<button onclick='window.location = \"/dlna.php\";'>Back</button>";
		echo "<hr><pre>";
		include '/var/log/minidlna.log';
		echo "</pre>";
        break;
	case 'daaplog':
		echo "<h2>DAAP Server Log</h2>";
		echo "<button onclick='window.location = \"/daap.php\";'>Back</button>";
		echo "<hr><pre>";
		include '/var/log/forked-daapd.log';
		echo "</pre>";
        break;		
		
    default:
	echo "Error.";
        break;   
}
?>