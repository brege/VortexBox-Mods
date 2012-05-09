{include file="header.tpl"}

<div id="main" class="column">

  <div class="app-head-wrap">
    <span class="app-head-block">Upgrade Status {include file='tooltip.tpl' Name='VortexBox Software Upgrade' File='upgrade'}</span>
	</div>

	<div class="section section-bonly">
		<button class="button button-submit" onclick='window.location = "/upgrade.php?action=Upgrade";'> Start Upgrade </button>
		<button class="button button-left" onclick='window.location = "/logview.php?action=upgradelog";'> Full Log </button>
		<button class="button button-right" onclick='window.location = "/upgrade.php?action=ClearUpgradeLog";'> Clear Log </button>
		<button class="button button-stop" onclick='confirmAction("Are you sure you want to REBOOT your VortexBox?","/system.php?action=Reboot");'> Reboot </button>
	</div>

  <div class="sub-head-wrap">
		<span class="sub-head-block">Package Manager</span>
  </div>

	<div class="section">
		<div class="texttable">
			<table>
				<tr>
					<th style="text-align: left;">Packages</th>
					<th style="text-align: left;">State</th>
					<th>Add or Remove</th>
				</tr>
				{section name=list loop=$packages}
				{strip}
				<tr class="{cycle values="odd,even"}">
					<td style="text-align: left;">{$packages[list].name}</td>
					<td style="text-align: left;"><span class="{if $packages[list].state eq 'Installed'}is{else}isnt{/if}">{$packages[list].state}</span></td>
					<td ><button class="button button-left" onclick='window.location = "/upgrade.php?action=Install&package={$packages[list].shortname}";'> Install </button>
				  <button class="button button-right" onclick='window.location = "/upgrade.php?action=Delete&package={$packages[list].shortname}";'> Remove </button></td>
				</tr>
				{/strip}
				{/section}
			</table>
		</div>
    <p>Click on <a href="/upgrade.php">VortexBox Upgrade</a> on the left to update the log display.</p>
	</div>

  <div class="sub-head-wrap">
		<span class="sub-head-block">Upgrade and installation log</span>
  </div>

	<div id="log" class="log-upgrade">Empty.</div>

</div>

<script type="text/javascript">getLog('upgradelog');</script>

{include file="menu.tpl"}
