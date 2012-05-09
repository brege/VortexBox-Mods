{include file="header.tpl"}

<script type="text/javascript" src="/js/ajax.js"> </script>

<div class="xsnazzy">
<b class="xtop"><b class="xb1"></b><b class="xb2 color_e">
</b><b class="xb3 color_e"></b><b class="xb4 color_e"></b></b>
<div class="xboxcontent">
<h1 class="color_e">Simplify Media Server Configuration</h1>

<div>
<button onclick='window.location = "/logview.php?action=SimplifyMedia";'>View full log</button>
<br>
<br>
<form action="{$SCRIPT_NAME}?action=submit" method="post">
	<div class="texttable">
	<p><b>SimpleMedia Server setup</b></p>
	<p><a target="_blank" href="http://www.simplifymedia.com/download.html">Download</a> and install SimplifyMedia for your client system. Enter the account information you create during installation below.</p>
	  <table>
		<tr >
			<td>Screen Name:</td>
			<td><input type="text" name="SCREENNAME" value="{$SCREENNAME}" size="32"></td>
		</tr>
		<tr>
			<td>Password</td>
			<td><input type="text" name="PASSWORD" value="{$PASSWORD}" size="32"></td>
		</tr>
		<tr>
			<td>System Name:</td>
			<td><input type="text" name="LOCATION" value="{$LOCATION}" size="32"></td>
		</tr>
	  </table>
	 </div>

<br>
<br>

<p><input type="submit" value="Submit"></p>
</form>
</div>

<p></p>
</div>
<b class="xbottom"><b class="xb4"></b><b class="xb3"></b>
<b class="xb2"></b><b class="xb1"></b></b>
</div>

{include file="footer.tpl"}
