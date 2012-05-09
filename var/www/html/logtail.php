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

// make sure this page is never cached
header("Cache-Control: no-cache, must-revalidate"); // HTTP/1.1
header("Expires: Sat, 26 Jul 1997 01:00:00 GMT"); // Date in the past

$_action = isset($_REQUEST['action']) ? $_REQUEST['action'] : 'default';

switch($_action) {
	case 'riplog':
		$cmd = "tail -40 /var/log/cdrip.log";
		exec("$cmd 2>&1", $output);
		foreach($output as $outputline) {
		 echo ("$outputline\n");
		}
        break;
	case 'mirrorlog':
		$cmd = "tail -30 /var/log/mirror.log";
		exec("$cmd 2>&1", $output);
		foreach($output as $outputline) {
		 echo ("$outputline\n");
		}
        break;
	case 'upgradelog':
		$cmd = "tail -30 /var/log/vbupgrade.log";
		exec("$cmd 2>&1", $output);
		foreach($output as $outputline) {
		 echo ("$outputline\n");
		}
        break;
	case 'usbbackup':
		$cmd = "tail -30 /var/log/usbbackup.log";
		exec("$cmd 2>&1", $output);
		foreach($output as $outputline) {
		 echo ("$outputline\n");
		}
        break;
    default:
		echo "Log does not exist.";
        break;   
}

?>
