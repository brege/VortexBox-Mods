{include file="header.tpl"}

<div id="main" class="column">

  <div class="app-head-wrap">
    <span class="app-head-block">Network Configuration{include file='tooltip.tpl' Name='VortexBox networtk configuration' File='network'}</span>
	</div>

  <div class="section">
	  <p>Changing your VortexBox's IP address will require reconnecting to the new address.</p>
	</div>

  <form action="{$SCRIPT_NAME}?action=submit" method="post">

	<div class="sub-head-wrap">
		<span class="sub-head-block">Network identities</span>
	</div>

	<div class="section table-alt">
		<div class="table-row"> 
			<span class="table-col-l">System name:</span>
			<span class="table-col-r"><input type="text" name="SYSNAME" value="{$SYSNAME}" size="20"/>{include file='tooltip.tpl' Name='VortexBox Network Name' File='network_name'}</span>
		</div>
		<div class="table-clear" ></div>	
		<div class="table-row"> 
			<span class="table-col-l">SMB workgroup name: </span>
			<span class="table-col-r"><input type="text" name="WORKGROUP" value="{$WORKGROUP}" size="20"/> {include file='tooltip.tpl' Name='VortexBox Workgroup' File='network_workgroup'}</span>
		</div>
		<div class="table-clear"></div>	
		<div class="table-row"> 
			<span class="table-col-l">Sonos share: </span>
			<span class="table-col-r">{html_checkboxes name='SONOS' options=$sonos_checkbox selected=$sonos_ischecked } {include file='tooltip.tpl' Name=' Enable Sonos support' File='network_sonos'}</span>
		</div>
		<div class="table-clear"></div>	
		<!--p>{html_checkboxes name='SONOS' options=$sonos_checkbox selected=$sonos_ischecked } {include file='tooltip.tpl' Name=' Enable Sonos support' File='network_sonos'}</p-->
	</div>

	<div class="sub-head-wrap">
		<span class="sub-head-block">Network settings</span>
	</div>

	<div class="section section-line">
		<p>IP address assignment: {include file='tooltip.tpl' Name='IP address assignment' File='network_dhcp'}</p>
    <p> {html_radios name='BOOTPROTO' options=$iptype_name selected=$BOOTPROTO separator='<br/>'}</p>
		<p>If DHCP is selected the rest of the fields will be ignored</p>
  </div>

	<div class="section section-line table-alt">
		<div class="table-row"> 
			<span class="table-col-l">IP address:</span>
			<span class="table-col-r"><input type="text" name="IPADDR" value="{$IPADDR}" size="15"/> {include file='tooltip.tpl' Name='IP address' File='network_ipaddress'}</span>
		</div>
		<div class="table-clear" ></div>	
		<div class="table-row"> 
			<span class="table-col-l">Subnet Mask:</span>
			<span class="table-col-r"><input type="text" name="NETMASK" value="{$NETMASK}" size="15"/> {include file='tooltip.tpl' Name='Subnet Mask' File='network_subnetmask'}</span>
		</div>
		<div class="table-clear" ></div>	
		<div class="table-row"> 
			<span class="table-col-l">Gateway:</span>
			<span class="table-col-r"><input type="text" name="GATEWAY" value="{$GATEWAY}" size="15"/> {include file='tooltip.tpl' Name='Gateway' File='network_gateway'}</span>
		</div>
		<div class="table-clear" ></div>	
		<div class="table-row"> 
			<span class="table-col-l">DNS1:</span>
			<span class="table-col-r"><input type="text" name="DNS1" value="{$DNS1}" size="15"/></span>
		</div>
		<div class="table-clear" ></div>	
		<div class="table-row"> 
			<span class="table-col-l">DNS2:</span>
			<span class="table-col-r"><input type="text" name="DNS2" value="{$DNS2}" size="15"/></span>
		</div>
		<div class="table-clear" ></div>	
		<div class="table-row"> 
			<span class="table-col-l">DNS3:</span>
			<span class="table-col-r"><input type="text" name="DNS3" value="{$DNS3}" size="15"/></span>
		</div>
		<div class="table-clear" ></div>	
		<div class="table-row"> 
			<span class="table-col-l">MAC address:</span>
			<span class="table-col-r">{$HWADDR|upper}</span>
		</div>
	</div>

  <div class="section">
		<p><input type="submit" class="button button-submit" value=" Submit "/> Apply network changes.</p>
	</div>

	
	</form>

</div>

{include file="menu.tpl"}
