{include file="header.tpl"}

<div id="main" class="column">

  <div class="app-head-wrap">
    <span class="app-head-block">System Configuration {include file='tooltip.tpl' Name='VortexBox System Configuration' File='sysconfig'}</span>
	</div>

  <div class="section section-bonly">
		<button class="button button-left button-stop" onclick='confirmAction("Are you sure you want to REBOOT your VortexBox?","/system.php?action=Reboot");'>Reboot</button>
		<button class="button button-right button-stop" style="border-left: 1px solid grey" onclick='confirmAction("Are you sure you want to POWER OFF your VortexBox?","/system.php?action=PowerDown");'>Shutdown</button>
		<button class="button" onclick='confirmAction("Are you sure you want to sync your VortexBox to an internet time server.","/system.php?action=SyncTime");'>Correct System Time</button>
		<span class="link-special"><a href="/licensemanager.php">License Manager</a></span>
	</div>

  <div class="sub-head-wrap">
		<span class="sub-head-block">Metrics</span>
  </div>

	<form action="{$SCRIPT_NAME}?action=submit" method="post">
	<div class="section section-line">
			<p><b>Current Date Time string: </b> {$CurrentDate}</p>
			<p><b>Time Zone:</b></p>
			<p>{html_options name='TIMEZONE' class="button" options=$tzlist selected=$CURRENTTIMEZONE}</p>
			<p><b>Temperature Format:</b></p>
			<p>{html_radios name='TEMPFORMAT' options=$TempFormatList selected=$CurrentTempFormat separator='<br />'}</p>
	</div>
  <div class="section">
			<p><input type="submit" class="button button-submit" value="Submit"/> Apply changes to fix system time and temperatures.</p>
	</div>
	</form>

  <div class="sub-head-wrap">
		<span class="sub-head-block">System Manager</span>
  </div>

	<div class="section">
		<div class="texttable">
			<table>
				<tr>
					<th style="text-align:left">Service</th>
					<th>Status</th>
					<th>Control</th>
				</tr>
				{foreach from=$servicestatus key=service item=s}
					{if $s.Status == "Running"}
						{assign var='color' value="green"}
					{elseif $s.Status == "Stopped"}
						{assign var='color' value="red"}
					{else}
						{assign var='color' value="unknown"}
					{/if}
				<tr>
				
					<td style="text-align: left;">{$s.Name}</td>
					<td><div class="status {if $s.Status eq 'Running'}isr{elseif $s.Status eq 'Stopped'}isrnt{else}unk{/if}" style="width: 20em; height: 1.8em;">{$s.Status}</div></td>
					<td style="padding-right: 0px;">
						<button class="button button-left" onclick='confirmAction("Are you sure you want to stop {$s.Name}?","/reload.php?action=ServiceStop&amp;service={$service}");'>Stop</button>
						<button class="button button-right" onclick='confirmAction("Are you sure you want to start {$s.Name}?","/reload.php?action=ServiceStart&amp;service={$service}");'>Start</button>
					</td>		
				</tr>
				{/foreach}	
			</table>
		</div>
	</div>

</div>

{include file="menu.tpl"}
