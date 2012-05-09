{include file="header.tpl"}

<div id="main" class="column">

  <div class="app-head-wrap ahw-undo">
    <span class="app-head-block">Configure VortexBox Player {include file='tooltip.tpl' Name='Configure VortexBox Player' File='vortexbox_player'}</span>
	</div>


  <div class="sub-head-wrap">
		<span class="sub-head-block">Audio hardware devices</span>
  </div>

	<form action="{$SCRIPT_NAME}?action=submit" method="post">
	<div class="section">
		<div class="texttable">
			<table>
				<tr>
					<th>Name {include file='tooltip.tpl' Name='VortexBox Player Name' File='vortexbox_player_name'}</th>
					<th>MAC address {include file='tooltip.tpl' Name='MAC address' File='vortexbox_player_mac'}</th>
					<th>Audio Device {include file='tooltip.tpl' Name='ALSA audio device' File='vortexbox_player_device'}</th>
					<th style="width: 6em;">Soft Vol. {include file='tooltip.tpl' Name='Software Volume Control' File='vortexbox_player_softvol'}</th>
				</tr>
				<tr>
					<td><input type="text" name="NAME0" value="{$NAME0}" size="25"/></td>
					<td><input type="text" name="MAC0" value="{$MAC0}" size="15"/></td>
					<td><input type="text" name="DEVICENAME0" value="{$DEVICENAME0}" size="15"/></td>
					<td>{html_checkboxes name='SOFTVOL0' options=$softvol_checkbox selected=$softvol_ischecked0 }</td>
				</tr>
				<tr>
					<td><input type="text" name="NAME1" value="{$NAME1}" size="25"/></td>
					<td><input type="text" name="MAC1" value="{$MAC1}" size="15"/></td>
					<td><input type="text" name="DEVICENAME1" value="{$DEVICENAME1}" size="15"/></td>
					<td>{html_checkboxes name='SOFTVOL1' options=$softvol_checkbox selected=$softvol_ischecked1 }</td>			
				</tr>
				<tr>
					<td><input type="text" name="NAME2" value="{$NAME2}" size="25"/></td>
					<td><input type="text" name="MAC2" value="{$MAC2}" size="15"/></td>
					<td><input type="text" name="DEVICENAME2" value="{$DEVICENAME2}" size="15"/></td>
					<td>{html_checkboxes name='SOFTVOL2' options=$softvol_checkbox selected=$softvol_ischecked2 }</td>		
				</tr>
				<tr>
					<td><input type="text" name="NAME3" value="{$NAME3}" size="25"/></td>
					<td><input type="text" name="MAC3" value="{$MAC3}" size="15"/></td>
					<td><input type="text" name="DEVICENAME3" value="{$DEVICENAME3}" size="15"/></td>
					<td>{html_checkboxes name='SOFTVOL3' options=$softvol_checkbox selected=$softvol_ischecked3 }</td>			
				</tr>
				<tr>
					<td><input type="text" name="NAME4" value="{$NAME4}" size="25"/></td>
					<td><input type="text" name="MAC4" value="{$MAC4}" size="15"/></td>
					<td><input type="text" name="DEVICENAME4" value="{$DEVICENAME4}" size="15"/></td>
					<td>{html_checkboxes name='SOFTVOL4' options=$softvol_checkbox selected=$softvol_ischecked4 }</td>			
				</tr>
			</table>
		 </div>
		<p><input class="button button-submit" type="submit" value="Submit"/> Apply changes to configure hardware audio devices.</p>
	</div>
	</form>

  <div class="sub-head-wrap">
		<span class="sub-head-block">ALSA device list</span>
  </div>

	<div class="section">
			<pre>{$CardList}</pre>
	</div>

  <div class="sub-head-wrap">
		<span class="sub-head-block">List of audio device ports</span>
  </div>

	<div class="section">
		<pre>{$CardOutputList}</pre>
	</div>


</div>

{include file="menu.tpl"}
