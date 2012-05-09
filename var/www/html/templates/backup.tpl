{include file="header.tpl"}

<div id="main" class="column">

  <div class="app-head-wrap">
    <span class="app-head-block">USB Backup</span>
	</div>

	<form>
  <div class="section section-line">
		<p><button class="button button-left" onclick='window.location = "/logview.php?action=usbbackup";'>Full Log</button>
		<button class="button button-right" onclick='confirmAction("Are you sure you want to clear your log?","/backup.php?action=ClearUsbBackupLog");'>Clear Log</button>
		{if $CurrentUsbDrive}
		<button class="button button-submit" onclick='confirmAction("Are you sure you want to backup /storage? This can take long time.","/backup.php?action=BackupStorage");'>Backup to USB</button>
		<button class="button" onclick='confirmAction("Are you sure you want to restore from the USB drive and ADD MISSING files to /storage?","/backup.php?action=RestoreAdd");'>Restore from USB</button>
		<button class="button button-stop" onclick='confirmAction("Are you sure you want stop the backup or restore?","/backup.php?action=StopBackup");'>Abort</button>
		<button class="button" onclick='confirmAction("Are you sure you want to format and DESTROY ALL DATA on your drive?","/backup.php?action=FormatDrive");'>Format Drive</button>
		{/if}</p>
	</div>
  <div class="section">
		<p>{$PrintString}</p>
	</div>
	</form>

  <div class="sub-head-wrap">
		<span class="sub-head-block">Backup log</span>
  </div>

	<div id="log" class="log-backup">
	Empty.
	</div>

</div>

<script type="text/javascript">getLog('usbbackup');</script>

{include file="menu.tpl"}
