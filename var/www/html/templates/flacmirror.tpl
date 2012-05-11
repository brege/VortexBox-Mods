{include file="header.tpl"}

<div id="main" class="column">

  <div class="app-head-wrap ahw-undo">
    <span class="app-head-block">Media Mirror{include file='tooltip.tpl' Name='Convert FLAC and MKV files to other formats' File='flac_mirror'}</span>
	</div>

  <div class="sub-head-wrap">
		<span class="sub-head-block">CD ripping options</span>
  </div>

  <div class=" section section-line section-bonly">
		<button class="button button-submit button-left" onclick='window.location = "/flacmirror.php?action=StartMirror";'>Start mp3 mirroring</button>
		<button class="button button-submit button-middle" onclick='window.location = "/flacmirror.php?action=StartMP4Mirror";'>Start ALAC mirroring</button>
		<button class="button button-submit button-right" onclick='window.location = "/flacmirror.php?action=StartOGGMirror";'>Start Ogg mirroring</button>
		<button class="button button-stop" onclick='window.location = "/flacmirror.php?action=StopMirror";'>Stop mirroring</button>
		<button class="button button-left " onclick='window.location = "/logview.php?action=mirrorlog";'>Full log</button>
		<button class="button button-right" onclick='confirmAction("Are you sure you want to clear your log?","/flacmirror.php?action=ClearMirrorLog");'>Clear log</button>
		<button class="button button-left" onclick='confirmAction("Are you sure you want to DELETE all your mp3s?","/flacmirror.php?action=DelMirror");'>Delete all mp3</button>
		<button class="button button-right" onclick='confirmAction("Are you sure you want to DELETE all your Oggs?","/flacmirror.php?action=DelOggMirror");'>Delete all Ogg</button>
  </div>

	<form action="{$SCRIPT_NAME}?action=submit" method="post">

	<div class="section section-line">
		<p><b>FLAC to mp3 mirroring</b></p>
		<p>mp3 Quality:  
		{html_options name='MP3QUALITY' options=$mp3qualitylist class="button" selected=$CURRENTTMP3QUALITY}&nbsp;
		{include file='tooltip.tpl' Name='MP3 quality selector' File='flac_mirror_mp3_quality'}</p>
		<p>{html_checkboxes name='AUTOMP3' options=$automp3_checkbox selected=$automp3_ischecked }&nbsp;
		{include file='tooltip.tpl' Name='Enable automatic mp3 mirroring' File='flac_mirror_automp3'}</p>
		<p>{html_checkboxes name='COVERMP3' options=$covermp3_checkbox selected=$covermp3_ischecked }&nbsp;
		{include file='tooltip.tpl' Name='Enable mp3 embedded cover art' File='flac_mirror_covermp3'}</p>
	</div>

	<div class="section section-line">
		<p><b>FLAC to ALAC (Apple lossless) mirroring</b></p>
		<p>{html_checkboxes name='AUTOAAC' options=$autoaac_checkbox selected=$autoaac_ischecked }&nbsp;
		{include file='tooltip.tpl' Name='Enable automatic ALAC mirroring' File='flac_mirror_autoaac'}</p>
	</div>

	<div class="section">
		<p><b>FLAC to Ogg Vorbis mirroring</b></p>
		<p>Ogg Vorbis Quality:  
		{html_options name='OGGQUALITY' options=$oggqualitylist class="button" selected=$CURRENTTOGGQUALITY}&nbsp;
		{include file='tooltip.tpl' Name='Ogg Vorbis quality selector' File='flac_mirror_ogg_quality'}</p>
		<p>{html_checkboxes name='AUTOOGG' options=$autoogg_checkbox selected=$autoogg_ischecked }&nbsp;
		{include file='tooltip.tpl' Name='Enable automatic Ogg mirroring' File='flac_mirror_autoogg'}</p>
	</div>

	<div class="sub-head-wrap">
		<span class="sub-head-block">DVD/BD ripping options</span>
	</div>

	<div class="section section-line">
		<p>{html_checkboxes name='LONGER' options=$longer_checkbox selected=$longer_ischecked } <input type="text" name="length" value="{$length}" size="4"/> seconds.</p>
	</div>

	<div class="section section-line">
		<p><b>MKV to MP4 mirroring </b></p>
		<p>{html_checkboxes name='MP4' options=$mp4_checkbox selected=$mp4_ischecked }&nbsp;
			 {include file='tooltip.tpl' Name='Enable MKV to MP4 remuxing' File='mkv_mirror_automp4'}</p>
	</div>

	<div class="section section-line">
		<p><b>MKV to M2TS mirroring</b></p>
		<p>{html_checkboxes name='M2TS' options=$m2ts_checkbox selected=$m2ts_ischecked }&nbsp;
			 {include file='tooltip.tpl' Name='Enable MKV to M2TS remuxing' File='mkv_mirror_autom2ts'}</p>
	</div>

	<div class="section">
		<p><input type="submit" class="button button-submit" value="Submit"/> Start or stop mirroring CD's and/or DVD/BD's on your next rip.</p>
	</div>

	</form>

</div>

{include file="menu.tpl"}
