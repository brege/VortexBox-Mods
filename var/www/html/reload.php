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

require '/var/www/html/libs/vortexbox_defs.php';

header('Location: http://'.$ipaddress.'/system.php');

$_action = isset($_REQUEST['action']) ? $_REQUEST['action'] : 'default';

if (isset($_REQUEST['service']) & !$_REQUEST['service'] =="") { $service= $_REQUEST['service']; }

$FilteredService = "Unknown";

foreach ($servicestatus as $key => $value) {
	if ($key == $service) { 
	 $FilteredService = $key;
	 }
}

switch($_action) {

	case 'ServiceStart':
		exec("sudo /opt/vortexbox/doaction.sh ServiceStart ".$FilteredService."& >/dev/null 2>&1");
        break;
	case 'ServiceStop':
		exec("sudo /opt/vortexbox/doaction.sh ServiceStop ".$FilteredService."& >/dev/null 2>&1");
        break;		
    default:
	
        break;
}


?>
<html>
<Body>
Updating service status...
</Body>