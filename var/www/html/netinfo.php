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

$dnsmasqleases = array();
$x=0;
$file_handle = fopen("/var/lib/dnsmasq/dnsmasq.leases", "rb");

while (!feof($file_handle) ) {
$line_of_text = fgets($file_handle);
if (strlen($line_of_text) > 2)
	{
	$dnsmasqleases[$x] = explode(' ', $line_of_text);
	$x += 1;
	}
}

fclose($file_handle);

$smarty->assign('leases',$dnsmasqleases);
$smarty->display('netinfo.tpl');

?>
