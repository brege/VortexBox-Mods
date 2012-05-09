{include file="header.tpl"}

<div id="main" class="column">

  <div class="app-head-wrap">
    <span class="app-head-block">DLNA Server{include file='tooltip.tpl' Name='VortexBox DLNA server' File='dlna'}</span>
	</div>

  <div class="section">
		<p><button class="button button-left" onclick='window.location = "/logview.php?action=dlnalog";'> View log </button>
		<button class="button button-right" onclick='window.location = "/dlna.php?action=ClearDLNALog";'> Clear log </button>
		<button class="button button-stop" onclick='window.location = "/dlna.php?action=RescanDLNA";'> Rescan </button>
		<button class="button" onclick='window.location = "/dlna.php?action=ResetDefaults";'> Reset to defaults </button></p>
	</div>

  <div class="sub-head-wrap">
		<span class="sub-head-block">DLNA server configuration</span>
  </div>

	<form action="{$SCRIPT_NAME}?action=submit" method="post">
  <div class="section section-line table-alt">
		<div class="table-row"> 
			<div class="table-col-l">Audio Files:</div>
			<div class="table-col-r"><input type="text" name="AUDIOFILES" value="{$AUDIOFILES}" size="40"/> {include file='tooltip.tpl' Name='Audio files location' File='dlna_audiofiles'}</div>
		</div>
		<div class="table-clear" ></div>	
		<div class="table-row"> 
			<div class="table-col-l">Video Files:</div>
			<div class="table-col-r"><input type="text" name="VIDEOFILES" value="{$VIDEOFILES}" size="40"/> {include file='tooltip.tpl' Name='Video files location' File='dlna_videofiles'}</div>
		</div>
		<div class="table-clear" ></div>	
		<div class="table-row"> 
			<div class="table-col-l">Pictures:</div>
			<div class="table-col-r"><input type="text" name="PICTUREFILES" value="{$PICTUREFILES}" size="40"/> {include file='tooltip.tpl' Name='Pictures location' File='dlna_picturefiles'}</div>
		</div>
		<div class="table-clear" ></div>	
		<div class="table-row"> 
			<div class="table-col-l">Description:</div>
			<div class="table-col-r"><input type="text" name="DESCRIPTION" value="{$DESCRIPTION}" size="40"/> {include file='tooltip.tpl' Name='DLNA server description' File='dlna_description'}</div>
		</div>
		<div class="table-clear" ></div>	
		<div class="table-row"> 
			<div class="table-col-l">Max size of cover art:</div>
			<div class="table-col-r"><input type="text" name="ARTSIZE" value="{$ARTSIZE}" size="4"/> px {include file='tooltip.tpl' Name='DLNA server cover art size' File='dlna_coverart'}</div>
		</div>
	</div>
	<div class="section">
		<p><input type="submit" class="button button-submit" value=" Submit "/> Apply path changes and restart the DLNA server.</p>
	</div>
	</form>

</div>

{include file="menu.tpl"}
