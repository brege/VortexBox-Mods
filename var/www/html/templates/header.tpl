<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en" id="vortexbox_html">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252"/>
<link id="page_favicon" href="images/favicon.ico" rel="icon" type="image/x-icon" />
<title>VortexBox</title>
<link rel="shortcut icon" href="images/favicon.ico" />
<link href="/css/vortexbox.css" rel="stylesheet" type="text/css"/>
<link href="/css/buttons.css" rel="stylesheet" type="text/css"/>
<link href="/css/jtip.css" rel="stylesheet" type="text/css"/>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="/js/jquery.js" type="text/javascript"></script>
<script src="/js/jtip.js" type="text/javascript"></script>
<script type="text/javascript" src="/js/ajax.js"> </script>
<script type="text/javascript" src="/js/logtail.js"> </script>

</head>
<body>

<div id="header">
	<div class="header-news">
		<a href="http://vortexbox.org/"><img alt="vortexbox.org" src="images/vortexbox.png" class="header-news-image"/></a> 
  	<span class="header-news-text">{include file="../news.html"}</span>
  </div>
  <div class="header-reboot">
 		<a href="javascript:void(null)" onclick='confirmAction("Are you sure you want to REBOOT your VortexBox?","/system.php?action=Reboot");'><img border="0" alt="Clicking here brings you to the page for reboot and shutdown." src="images/reboot.png" class="header-reboot-image"/></a>
	</div>
</div>

{ if file_exists("/var/www/html/images/oem_logo.png") }
 <div style="position: absolute; left: 628px; top: 5px;">
	<a href="{include file="../config/oem_url.inc"}"><img border="0" src="images/oem_logo.png" width="150" height="50"></a> 
 </div>
{/if}
