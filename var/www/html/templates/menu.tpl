<div id="left" class="column">
	<div class="menu-wrapper">
		<div id="highlight">  
		{foreach from=$IconList key=IconId item=i}
			<a href="{$i.link}" {if $i.newtab eq '1'} target="_blank" {/if} class="menu-tiles {if $smarty.server.REQUEST_URI eq $i.link}menu-tiles-this{/if}">
				<img border="0" src="images/{$i.icon}" title="" alt="" class="menu-tiles-image {if $smarty.server.REQUEST_URI eq $i.link}menu-tiles-image-this{/if}"/>
				<span class="menu-tiles-text {if $smarty.server.REQUEST_URI eq $i.link}menu-tiles-text-this{/if}">{$i.name}</span>
			</a>
		{/foreach}
		</div>
  </div>
</div>

{include file="footer.tpl"}
