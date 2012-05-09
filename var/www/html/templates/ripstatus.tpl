{include file="header.tpl"}

<div id="main" class="column">

  <div class="app-head-wrap">
    <span class="app-head-block">CD and DVD auto ripper{include file='tooltip.tpl' Name='VortexBox CD and DVD auto ripper status' File='ripping_status'}</span>
	</div>

  <div class="section section-bonly">
		<button class="button button-stop" onclick='window.location = "/ripstatus.php?action=RestartRipper";'> Restart Auto Ripper </button>
		<button class="button button-left" onclick='window.location = "/logview.php?action=riplog";'> Full Log </button>
		<button class="button button-right" onclick='window.location = "/ripstatus.php?action=ClearLog";'> Clear Log </button>
		<button class="button" onclick='window.location = "/ripstatus.php?action=GetCovers";'> Get Cover Art </button>
		<button class="button" onclick='window.location = "/ripstatus.php?action=CloseTray";'> Close tray </button>
	</div>

  <div class="sub-head-wrap">
		<span class="sub-head-block">Rip log</span>
  </div>

	<div id="log" class="log-rip">
	Empty.
	</div>

</div>

<script type="text/javascript">getLog('riplog');</script>

{include file="menu.tpl"}
