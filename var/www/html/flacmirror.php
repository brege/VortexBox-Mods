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
$length = isset($_REQUEST['length']) ? $_REQUEST['length'] : '120';

/*------------------------------------------------------------------
CD Options
------------------------------------------------------------------*/

if (file_exists($lamopt)) {
	$lamoptraw = file($lamopt);
	$MP3QUALITY = trim($lamoptraw[0]);
} else {
	$MP3QUALITY = "-V2";
	if ($fp = fopen($lamopt, 'w')) {
		fwrite($fp, $MP3QUALITY);
		fclose($fp);
	} else {
		echo 'Config file unwritable... '; 
	}	
}

if (file_exists($oggopt)) {
	$oggoptraw = file($oggopt);
	$OGGQUALITY = trim($oggoptraw[0]);
} else {
	$OGGQUALITY = "-q8 -o";
	if ($fq = fopen($oggopt, 'w')) {
		fwrite($fq, $OGGQUALITY);
		fclose($fq);
	} else {
		echo 'Config file unwritable... '; 
	}	
}

$smarty->assign('automp3_checkbox', array(
					'automp3' => '&nbsp;Enable automatic mp3 mirroring',
                     ));

if (file_exists("/etc/vortexbox/automp3")) {
	$smarty->assign('automp3_ischecked', "automp3");
} else {
	$smarty->assign('automp3_ischecked', "no");
}

$smarty->assign('covermp3_checkbox', array(
					'covermp3' => '&nbsp;Enable mp3 embedded cover art',
                     ));

if (file_exists("/etc/vortexbox/covermp3")) {
	$smarty->assign('covermp3_ischecked', "covermp3");
} else {
	$smarty->assign('covermp3_ischecked', "no");
}

$smarty->assign('autoaac_checkbox', array(
					'autoaac' => '&nbsp;Enable automatic ALAC mirroring',
                     ));

if (file_exists("/etc/vortexbox/autoaac")) {
	$smarty->assign('autoaac_ischecked', "autoaac");
} else {
	$smarty->assign('autoaac_ischecked', "no");
}

$smarty->assign('autoogg_checkbox', array(
					'autoogg' => '&nbsp;Enable automatic Ogg mirroring',
                     ));

if (file_exists("/etc/vortexbox/autoogg")) {
	$smarty->assign('autoogg_ischecked', "autoogg");
} else {
	$smarty->assign('autoogg_ischecked', "no");
}

$smarty->assign('CURRENTTMP3QUALITY', $MP3QUALITY);

$smarty->assign('mp3qualitylist', array(
	'-b320' => 'Insane (320Kbit/s CBR)',
	'-V0' => 'Extreme (245Kbit/s VBR)',
	'-V2' => 'Standard (190Kbit/s VBR)',
	'-V4' => 'Medium (160Kbit/s VBR)'
));

$smarty->assign('CURRENTTOGGQUALITY', $OGGQUALITY);

$smarty->assign('oggqualitylist', array(
	'-q10' => 'q10 (500 kbit/s)',
	'-q9' => 'q9 (320 kbit/s)',
	'-q8' => 'q8 (256 kbit/s)',
	'-q7' => 'q7 (224 kbit/s)',
	'-q6' => 'q6 (192 kbit/s)',
	'-q5' => 'q5 (160 kbit/s)',
	'-q4' => 'q4 (128 kbit/s)'
));

/*------------------------------------------------------------------
DVD/BD Options
------------------------------------------------------------------*/

$smarty->assign('longer_checkbox', array(
					'longer' => ' Rip any tracks longer than',
                     ));

if (file_exists("/etc/vortexbox/ripdvdlength")) {
  $smarty->assign('longer_ischecked', "longer");
	$smarty->assign('length', trim(exec("/bin/cat /etc/vortexbox/ripdvdlength")));
} else {
	$smarty->assign('longer_ischecked', "no");
}

$smarty->assign('mp4_checkbox', array(
					'mp4' => ' Mirror tracks to mp4',
                     ));

if (file_exists("/etc/vortexbox/riptomp4")) {
	$smarty->assign('mp4_ischecked', "mp4");
} else {
	$smarty->assign('mp4_ischecked', "no");
}

$smarty->assign('m2ts_checkbox', array(
					'm2ts' => ' Mirror tracks to m2ts',
                     ));

if (file_exists("/etc/vortexbox/riptom2ts")) {
	$smarty->assign('m2ts_ischecked', "m2ts");
} else {
	$smarty->assign('m2ts_ischecked', "no");
}

/*------------------------------------------------------------------
Switch Cases
------------------------------------------------------------------*/

switch($_action) {

/* CD cases */
	case 'StartMirror':
		exec("sudo /opt/vortexbox/doaction.sh StartMirror & >/dev/null 2>&1");
        break;

	case 'StopMirror':
		exec("sudo /opt/vortexbox/doaction.sh StopMirror & >/dev/null 2>&1");
        break;

	case 'DelMirror':
		exec("sudo /opt/vortexbox/doaction.sh DelMirror & >/dev/null 2>&1");
        break;

	case 'DelOggMirror':
		exec("sudo /opt/vortexbox/doaction.sh DelOggMirror & >/dev/null 2>&1");
        break;

	case 'ClearMirrorLog':
		exec("sudo /opt/vortexbox/doaction.sh ClearMirrorLog & >/dev/null 2>&1");
        break;
	
	case 'StartMP4Mirror':
		exec("sudo /opt/vortexbox/doaction.sh StartMP4Mirror & >/dev/null 2>&1");
        break;

	case 'StartOGGMirror':
		exec("sudo /opt/vortexbox/doaction.sh StartOGGMirror & >/dev/null 2>&1");
        break;

/* On Submit */
		
	case 'submit':
		/* CD Submit */
		if (isset($_REQUEST['AUTOMP3'][0]) & !$_REQUEST['AUTOMP3'][0] =="") {
			exec("touch /etc/vortexbox/automp3");
		} else {
			exec("rm /etc/vortexbox/automp3");
		}
	
		if (isset($_REQUEST['AUTOAAC'][0]) & !$_REQUEST['AUTOAAC'][0] =="") {
			exec("touch /etc/vortexbox/autoaac");
		} else {
			exec("rm /etc/vortexbox/autoaac");
		}

		if (isset($_REQUEST['AUTOOGG'][0]) & !$_REQUEST['AUTOOGG'][0] =="") {
			exec("touch /etc/vortexbox/autoogg");
		} else {
			exec("rm /etc/vortexbox/autoogg");
		}

		if (isset($_REQUEST['COVERMP3'][0]) & !$_REQUEST['COVERMP3'][0] =="") {
			exec("touch /etc/vortexbox/covermp3");
		} else {
			exec("rm /etc/vortexbox/covermp3");
		}
	
		if (isset($_REQUEST['MP3QUALITY']) & !$_REQUEST['MP3QUALITY'] =="") { $MP3QUALITY = $_REQUEST['MP3QUALITY']; }
		if ($fp = fopen($lamopt, 'w')) {
			fwrite($fp, $MP3QUALITY);
			fclose($fp);
		} else {
			echo 'Config file unwritable... '; 
		}	

		if (isset($_REQUEST['OGGQUALITY']) & !$_REQUEST['OGGQUALITY'] =="") { $OGGQUALITY = $_REQUEST['OGGQUALITY']; }
		if ($fq = fopen($oggopt, 'w')) {
			fwrite($fq, $OGGQUALITY);
			fclose($fq);
		} else {
			echo 'Config file unwritable... '; 
		}	

		/*DVD/BD Submit*/
		$length = (int)$length;
		if ( $length < 120 ) { $length = 120;}
		if ( $length > 14400 ) { $length = 14400;}
	
		if (isset($_REQUEST['LONGER'][0]) & !$_REQUEST['LONGER'][0] =="") {
			exec("echo ".$length." > /etc/vortexbox/ripdvdlength");
		} else {
			exec("rm /etc/vortexbox/ripdvdlength");
		}
		if (isset($_REQUEST['MP4'][0]) & !$_REQUEST['MP4'][0] =="") {
			exec("touch /etc/vortexbox/riptomp4");
		} else {
			exec("rm /etc/vortexbox/riptomp4");
		}
		if (isset($_REQUEST['M2TS'][0]) & !$_REQUEST['M2TS'][0] =="") {
			exec("touch /etc/vortexbox/riptom2ts");
		} else {
			exec("rm /etc/vortexbox/riptom2ts");
		}
    break;	

	  default: break;   
}




/*
switch($_action) {

  case 'submit':
		$length = (int)$length;
		if ( $length < 120 ) { $length = 120;}
		if ( $length > 14400 ) { $length = 14400;}
	
		if (isset($_REQUEST['LONGER'][0]) & !$_REQUEST['LONGER'][0] =="") {
			exec("echo ".$length." > /etc/vortexbox/ripdvdlength");
		} else {
			exec("rm /etc/vortexbox/ripdvdlength");
		}
		if (isset($_REQUEST['MP4'][0]) & !$_REQUEST['MP4'][0] =="") {
			exec("touch /etc/vortexbox/riptomp4");
		} else {
			exec("rm /etc/vortexbox/riptomp4");
		}
		if (isset($_REQUEST['M2TS'][0]) & !$_REQUEST['M2TS'][0] =="") {
			exec("touch /etc/vortexbox/riptom2ts");
		} else {
			exec("rm /etc/vortexbox/riptom2ts");
		}
    break;	
	default: break;   
}
*/

$smarty->display('flacmirror.tpl');

?>
