{include file="header.tpl"}

<div class="xsnazzy">
<b class="xtop"><b class="xb1"></b><b class="xb2 color_c">
</b><b class="xb3 color_c"></b><b class="xb4 color_c"></b></b>
<div class="xboxcontent">
<h1 class="color_c">Network Information</h1>

<div>
</div>

<div id="log" style="border:solid 0px #dddddd; width:675px;  height:680x; font-size:11px;
padding-left:10px; padding-right:10px; padding-top:10px; padding-bottom:20px;
margin-bottom:10px; text-align:left;">
<strong>DHCP Leases</strong></br></br>
<table>
  <tr>
    <th>Mac address</th>
    <th>IP address</th>
	<th>Name</th>
  </tr>
{foreach from=$leases item=lease}
{strip}
   <tr bgcolor="{cycle values="#BBBBBB,#FFFFFF"}">
      <td>{$lease[1]|upper}&nbsp;</td>
	  <td><a href="http://{$lease[2]}">{$lease[2]}</a>&nbsp;</td>
	  <td>{$lease[3]}&nbsp;</td>
   </tr>
{/strip}
{/foreach}
</table>

</div>

<p></p>
</div>
<b class="xbottom"><b class="xb4"></b><b class="xb3"></b>
<b class="xb2"></b><b class="xb1"></b></b>
</div>

{include file="footer.tpl"}
