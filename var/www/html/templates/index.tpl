{include file="header.tpl"}

<div id="main" class="column">

  <div class="app-head-wrap">
    <span class="app-head-block">Main Menu</span>
	</div>

  <div class="section">
		<p>Welcome to your VortexBox.</p>
		<p>If you need help, please check out the documentation section and the user forum on <a href="http://vortexbox.org">VortexBox.org.</a></p>
	</div>

  <div class="sub-head-wrap">
		<span class="sub-head-block">Overview</span>
  </div>

  <div class="section table-alt">
		<div class="table-row"> 
			<span class="table-col-l tcl-b">System name: </span>
			<span class="table-col-r">{$SYSNAME}</span>
		</div>
		<div class="table-clear" ></div>	
		<div class="table-row"> 
			<span class="table-col-l tcl-b">VortexBox SW Version: </span>
			<span class="table-col-r">{$VORTEXBOXVERSION}</span>
		</div>
		<div class="table-clear"></div>	
		<div class="table-row"> 
			<span class="table-col-l tcl-b">Linux OS Version: </span>
			<span class="table-col-r">{$FEDORAVER}</span>
		</div>
		<div class="table-clear"></div>	
		<div class="table-row"> 
			<span class="table-col-l tcl-b">{$NIC} IP: </span>
			<span class="table-col-r">{$IPADDRESS}</span>
		</div>
		<div class="table-clear"></div>	
		<div class="table-row"> 
			<span class="table-col-l tcl-b">eth0 MAC: </span>
			<span class="table-col-r">{$MACADDRESS}</span>
		</div>
		<div class="table-clear"></div>	
		{if $RAIDSTATUS != '0' }
		<div class="table-row"> 
			<span class="table-col-l tcl-b">RAID Status: </span>
			<span class="table-col-r">{$RAIDSTATUS}</span>
		</div>
		<div class="table-clear"></div>	
		{/if}
  </div>

  <div class="sub-head-wrap">
		<span class="sub-head-block">Storage</span>
  </div>

  <div class="section">
		<div class="drive table-alt">
		 <table>
			<tr><th>Filesystem</th>
				<th>Size</th>
				<th>Used</th>
				<th>Available</th>
				<th>Use%</th>
			</tr>
			<tr><td>/storage</td>
				<td>{$STORAGESIZE}</td>
				<td>{$STORAGEUSED}</td>
				<td>{$STORAGEAVAIL}</td>
				<td>{$STORAGEPERCENT}</td>
			</tr>
		 </table>
		</div>
	</div>
</div>

{include file="menu.tpl"}
