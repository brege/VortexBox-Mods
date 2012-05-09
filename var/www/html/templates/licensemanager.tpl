{include file="header.tpl"}

<script type="text/javascript" src="/js/ajax.js"> </script>

<div id="main" class="column">

  <div class="app-head-wrap">
    <span class="app-head-block">License Manager {include file='tooltip.tpl' Name='VortexBox License Manager' File='licensemanager'}</span>
	</div>

  <div class="section">
		<form action="{$SCRIPT_NAME}?action=submit" method="post">
			<p><b>MakeMKV License:</b>   (Buy a license <a href="http://makemkv.com/buy/" target="_blank" >here</a> if you don't have one.)</p>
			<p><input type="text" name="MAKEMKVLICENSE" value="{$MAKEMKVLICENSE}" size="70"> 
			<input class="button button-submit" type="submit" value="Submit"></p>
		</form>
  </div>

</div>

{include file="menu.tpl"}
