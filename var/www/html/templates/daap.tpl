{include file="header.tpl"}

<div id="main" class="column">

  <div class="app-head-wrap">
    <span class="app-head-block">DAAP (iTunes) Server{include file='tooltip.tpl' Name='VortexBox DAAP server' File='daap'}</span>
	</div>

  <div class="section">
		<p><button class="button" onclick='window.location = "/logview.php?action=daaplog";'>View Log</button>
		<button class="button" onclick='window.location = "/daap.php?action=ResetDefaults";'>Reset to Defaults</button>
		<button class="button button-red" onclick='confirmAction("Are you sure you want to delete the DAAP database and restart the DAAP server?","/daap.php?action=DAAPDeleteDatabase");'>Delete Database</button></p>
	</div>


  <div class="sub-head-wrap">
		<span class="sub-head-block">DAAP (iTunes) server configuration</span>
  </div>

	<form action="{$SCRIPT_NAME}?action=submit" method="post">
  <div class="section section-line">
		<p>Audio Files: <input type="text" name="DIRECTORIES" value="{$DIRECTORIES}" size="40"/> {include file='tooltip.tpl' Name='Files location' File='daap_filelocation'}</p>
		<p>Description: <input type="text" name="DESCRIPTION" value="{$DESCRIPTION}" size="40"/> {include file='tooltip.tpl' Name='DAAP server description' File='daap_description'}</p>
	</div>

  <div class="section">
		<p><input class="button button-submit" type="submit" value="Submit"> Press submit to update your config and restart the DAAP server.</p>
	</div>
	</form>

</div>

{include file="menu.tpl"}
