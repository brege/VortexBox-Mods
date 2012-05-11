#!/bin/sh
# Copyright (C) 2008 - 2012 vortexbox.org
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# Changelog
#
# Wed Jun 15 2011 Ron Olsen <wyatt.brege@gmail.com>
# * Add $flacdir and $oggdir arguments to call to flac2ogg.sh
# * Add CloseTray action
#
# Thurs Mar 22 2012 Ron Olsen <ronolsen@comcast.net>
# * Stop ntpd service, not ntpdate service, when resetting System Time or setting Time Zone.
#
# Tues Feb 07 2012 Ron Olsen <ronolsen@comcast.net>
# * Call format-usb-drive to handle FormatDrive operation.
#
# Sat Jun 25 2011 Ron Olsen <ronolsen@comcast.net>
# * Improve error checking and error messages on backup, restore, upgrade, install.
#
# Thurs Jun 23 2011 Ron Olsen <ronolsen@comcast.net>
# * Add RestoreAdd action
# * Based on code from Steve Gray <amawalk@gmail.com>
#
# Wed Jun 15 2011 Ron Olsen <ronolsen@comcast.net>
# * Add $flacdir and $m4adir arguments to call to flac2m4a.sh
#
# Tues Jun 14 2011 Ron Olsen <ronolsen@comcast.net>
# * Ping yum.vortexbox.org as well as google.com on Upgrade action to ensure availability of VortexBox repository.
#
# Mon May 23 2011 Ron Olsen <ronolsen@comcast.net>
# * Change /usr/sbin/mkntfs to /sbin/mkntfs to reflect new location in ntfsprogs-2011-4.12-3
#
# Tues May 10 2011 Ron Olsen <ronolsen@comcast.net>
# * Change RestartRipper action to use /opt/vortexbox/get-cddevice to determine which device to eject.
#
# Fri Apr 2 2010 Ron Olsen <ronolsen@comcast.net>
# * Fix FormatDrive action:
# - add --force option to sfdisk
# - do dd after sfdisk
# - unmount /backup when done

ACTION=$1
PACKAGE=$2
NOW=`date +'%m/%d/%Y %H:%M:%S'`
function echolog {
echo "`date +'%m/%d/%Y %H:%M:%S'` - $1"
}
 
case $ACTION in
  Reboot )
	echo "Reboot"
	reboot
	;;
	
  PowerDown )
	echo "PowerDown"
	poweroff
	;;
	
  CloseTray )
	echo "CloseTray"
	echolog "<b>Closing disk tray...</b>" >> /var/log/cdrip.log
	eject -t `/opt/vortexbox/get-cddevice`
	;;

  RestartRipper )
	echo "RestartRipper"
	echolog "<b>Restarting Auto Ripper...</b>" >> /var/log/cdrip.log
	service vortexbox stop
	sleep 1
	echolog "<b>Ejecting Disk...</b>" >> /var/log/cdrip.log
	eject `/opt/vortexbox/get-cddevice`
	service vortexbox start
	;;
	
  GetCovers )
	echo "GetCovers"
	if ping -c 1 -w 5 "google.com" &>/dev/null ; then
	  echolog "Getting cover art for all your FLACs." >> /var/log/cdrip.log
	  /opt/vortexbox/getcoverart
	  echolog "Getting cover art for your FLACs complete." >> /var/log/cdrip.log
	else
	  echolog "Internet not avalible. Could not get cover art." >> /var/log/cdrip.log
	  echolog "(Your DNS may not be working)" >> /var/log/cdrip.log
	fi	
	;;	
	
  ClearLog )
	echo "ClearLog"
	echolog "Ripper log cleared." > /var/log/cdrip.log
	;;

  ClearMirrorLog )
	echo "ClearMirrorLog"
	echolog "FLAC mirroring log cleared." > /var/log/mirror.log
	;;
	
  ClearUsbBackupLog )
	echo "ClearUsbBackupLog"
	echolog "USB backup log cleared." > /var/log/usbbackup.log
	;;
	
  ClearUpgradeLog )
	echo "ClearUpgradeLog"
	echolog "Upgrade log cleared." > /var/log/vbupgrade.log
	;;

  ClearDLNALog )
	echo "ClearDLNALog"
	echolog "miniDLNA log cleared." > /var/log/minidlna.log
	;;	
	
  StartMirror )
	echo "StartMirror"
	if [ -f /etc/vortexbox/mirror-flac-mp3.running ]; then
		echo "" >> /var/log/mirror.log
		echolog "Mp3 mirroring already in progress." >> /var/log/mirror.log
		echo "" >> /var/log/mirror.log
	else
		echo "" >> /var/log/mirror.log
		echolog "Mirroring FLACs to mp3." >> /var/log/mirror.log
		echo "" >> /var/log/mirror.log
		/usr/local/sbin/mirror-flac-mp3 >> /var/log/mirror.log &
	fi
	;;
	
  StartMP4Mirror )
	echo "StartMP4Mirror"
	flacdir=/storage/music/flac/
	m4adir=/storage/music/m4a/
	
	if [ -f /etc/vortexbox/mirror-flac-aac.running ]; then
		echo "" >> /var/log/mirror.log
		echolog "AAC mirroring already in progress." >> /var/log/mirror.log
		echo "" >> /var/log/mirror.log
	else
		echo "" >> /var/log/mirror.log
		echolog "Mirroring FLACs to AAC." >> /var/log/mirror.log
		echo "" >> /var/log/mirror.log
		/usr/local/sbin/flac2m4a.sh "$flacdir" "$m4adir" >> /var/log/mirror.log &
	fi
	;;

  StartOGGMirror )
	echo "StartOGGMirror"
	flacdir=/storage/music/flac
	oggdir=/storage/music/ogg

  if [ -f /etc/vortexbox/oggopt.txt ]; then
	  oggopt="`cat /etc/vortexbox/oggopt.txt` -o"
	else
		oggopt="-q8 -o"
  fi
	if [ -f /etc/vortexbox/mirror-flac-ogg.running ]; then
		echo "" >> /var/log/mirror.log
		echolog "OGG mirroring already in progress." >> /var/log/mirror.log
		echo "" >> /var/log/mirror.log
	else
		echo "" >> /var/log/mirror.log
		echolog "Mirroring FLACs to Ogg Vorbis." >> /var/log/mirror.log
		echo "" >> /var/log/mirror.log
		/usr/local/sbin/flac2ogg.sh "$flacdir" "$oggopt" "$oggdir" >> /var/log/mirror.log &    
	fi
	;;

  StopMirror )
	echo "StopMirror"
	echo "" >> /var/log/mirror.log
	echolog "FLAC mirroring stopped." >> /var/log/mirror.log
	echo "" >> /var/log/mirror.log
	pkill -f flac2mp3.pl
	pkill -f flac2m4a.sh
	pkill -f flac2ogg.sh
	rm /etc/vortexbox/mirror-flac-mp3.running
	rm /etc/vortexbox/mirror-flac-aac.running	
	rm /etc/vortexbox/mirror-flac-ogg.running	
	;;
	
  DelMirror )
	echo "DelMirror"
	echolog "Making sure FLAC mirroring is stopped ." >> /var/log/mirror.log
	pkill -f flac2mp3.pl
	rm /etc/vortexbox/mirror-flac.running
	sleep 3
	echolog "Clearing mp3 files from /storage/music/mp3/." >> /var/log/mirror.log
	rm -rfv /storage/music/mp3/* >> /var/log/mirror.log
	echolog "mp3 files cleared." >> /var/log/mirror.log
	;;	
	
  DelOggMirror )
	echo "DelOggMirror"
	echolog "Making sure FLAC to Ogg mirroring is stopped." >> /var/log/mirror.log
	pkill -f flac2ogg.sh
	rm /etc/vortexbox/mirror-flac.running
	sleep 3
	echolog "Clearing Ogg files from /storage/music/ogg/." >> /var/log/mirror.log
	rm -rfv /storage/music/ogg/* >> /var/log/mirror.log
	echolog "Ogg files cleared." >> /var/log/mirror.log
	;;	

  NewTZ )
	echo "NewTZ"
	echo "ZONE=\"$2\"" > /etc/sysconfig/clock
	rm /etc/localtime
	ln -sf /usr/share/zoneinfo/$2 /etc/localtime
	/bin/systemctl stop ntpd.service
	/usr/sbin/ntpdate pool.ntp.org
	if [ $? -ne 0 ]
	then
	   echo "ntpdate returns $?; try again"
	   sleep 2
	   /usr/sbin/ntpdate pool.ntp.org	
	fi
	/bin/systemctl start ntpd.service
	;;
	
  SyncTime )
	echo "SyncTime"
	/bin/systemctl stop ntpd.service
	/usr/sbin/ntpdate pool.ntp.org
	if [ $? -ne 0 ]
	then
	   echo "ntpdate returns $?; try again"
	   sleep 2
	   /usr/sbin/ntpdate pool.ntp.org	
	fi
	/bin/systemctl start ntpd.service
	;;
	
  UsbDiskInfo )
	echo "UsbDiskInfo"
	USBDISK=`cat /etc/vortexbox/CurrentUsbDrive.txt` 
	parted $USBDISK print |tail -2 | head -1 |sed "s/  */ /g" | cut -f5 -d" "
	#/sbin/fdisk -l $USBDISK | grep -m1 Disk
	;;
	
  FormatDrive )
  	echo "FormatDrive"
	USBDISK=`cat /etc/vortexbox/CurrentUsbDrive.txt`
	echolog "Formatting USB drive $USBDISK with NTFS..." >> /var/log/usbbackup.log
	/bin/umount /backup
	rm -rf /backup/*
        /opt/vortexbox/format-usb-drive $USBDISK >> /var/log/usbbackup.log 2>&1
	if [ $? ]
	then
	    echolog "Done formatting USB drive $USBDISK." >> /var/log/usbbackup.log
        else
	    echolog "Formatting USB drive $USBDISK failed!" >> /var/log/usbbackup.log
	fi
	;;
	
  StopBackup )
  	echo "StopBackup"
	/usr/bin/pkill rsync
        echolog "Backup or Restore aborted by user." >> /var/log/usbbackup.log
        rm -f /etc/vortexbox/backup.running /etc/vortexbox/restore.running
	;;
	
  BackupStorage )
        echo "" >> /var/log/usbbackup.log
  	echolog "Backup /storage to USB drive..." >> /var/log/usbbackup.log
        echo "" >> /var/log/usbbackup.log
          
	if [ -f /etc/vortexbox/restore.running ]; then
		echo "" >> /var/log/usbbackup.log
		echolog "Restore in progress; cannot start Backup." >> /var/log/usbbackup.log
		echo "" >> /var/log/usbbackup.log
        elif [ -f /etc/vortexbox/backup.running ]; then
		echo "" >> /var/log/usbbackup.log
		echolog "Backup already in progress; continuing..." >> /var/log/usbbackup.log
		echo "" >> /var/log/usbbackup.log
	else
		USBDRIVE=$(cat /etc/vortexbox/CurrentUsbDrive.txt)1 
                umount $USBDRIVE
		mount $USBDRIVE /backup >> /var/log/usbbackup.log 2>&1
                if [ $? -ne 0 ]
                then
		     echo "" >> /var/log/usbbackup.log
                     echolog "Mount of USB drive $USBDRIVE failed; cannot do Backup." >> /var/log/usbbackup.log
		     echo "" >> /var/log/usbbackup.log
                else
		     if [ -f "/backup/VortexBox.txt" ]; then
                          echolog "USB drive OK; will now do Backup." >> /var/log/usbbackup.log
			  /opt/vortexbox/dobackup.sh &
		     else
		           echo "" >> /var/log/usbbackup.log
		           echolog "No VortexBox.txt file on USB drive; $USBDRIVE is not a VortexBox backup drive. Please format." >> /var/log/usbbackup.log
			   echo "" >> /var/log/usbbackup.log
		     fi
                fi
	fi
	;;

  RestoreAdd )
        echo "" >> /var/log/usbbackup.log
  	echolog "Restore (Add missing files) from USB drive to /storage..." >> /var/log/usbbackup.log
        echo "" >> /var/log/usbbackup.log
	if [ -f /etc/vortexbox/restore.running ]; then
		echo "" >> /var/log/usbbackup.log
		echolog "Restore already in progress; continuing..." >> /var/log/usbbackup.log
		echo "" >> /var/log/usbbackup.log
        elif [ -f /etc/vortexbox/backup.running ]; then
		echo "" >> /var/log/usbbackup.log
		echolog "Backup in progress; cannot start Restore." >> /var/log/usbbackup.log
		echo "" >> /var/log/usbbackup.log
	else
		USBDRIVE=$(cat /etc/vortexbox/CurrentUsbDrive.txt)1 
		umount $USBDRIVE
		mount $USBDRIVE /backup >> /var/log/usbbackup.log 2>&1
		if [ $? -ne 0 ]; then
			echo "" >> /var/log/usbbackup.log
			echolog "Mount of USB drive $USBDRIVE failed; cannot do Restore." >> /var/log/usbbackup.log
			echo "" >> /var/log/usbbackup.log
		else
			if [ -f "/backup/VortexBox.txt" ]; then
				echolog "USB drive OK; will now do Restore." >> /var/log/usbbackup.log
				/opt/vortexbox/dorestoreadd.sh &
			else
				echo "" >> /var/log/usbbackup.log
				echolog "No VortexBox.txt file on USB drive; $USBDRIVE is not a VortexBox backup drive. Please format." >> /var/log/usbbackup.log
				echo "" >> /var/log/usbbackup.log
			fi
		fi
	fi
	;;

 SimplifyMedia )
	echo "SimplifyMedia"
	chkconfig --add simplifymedia
	/sbin/service simplifymedia stop
	rm -rf /opt/simplifymedia/SimplifyPeer.log
	sleep 3
	/sbin/service simplifymedia start
	;;
 
 Upgrade )
	echo "Upgrade"
# make sure system time is right. Yum gets mad if its not.
	
	/sbin/service ntpd stop > /dev/null 2>&1
	/usr/sbin/ntpdate pool.ntp.org > /dev/null 2>&1
	/sbin/service ntpd start > /dev/null 2>&1

# Check for network access Yum wont work with no access to the Internet.
	
	if ping -c 1 -w 5 "google.com" &>/dev/null ; then
		if ping -c 1 -w 5 "yum.vortexbox.org" &>/dev/null ; then
			echo "" >> /var/log/vbupgrade.log
			echolog "Starting upgrade. (This can take a long time...)" >> /var/log/vbupgrade.log
			echo "" >> /var/log/vbupgrade.log
			# Make sure yum will work corectlly
			rm -rf /var/cache/yum/*
			rm -rf /var/lib/yum/yumdb/*
			yum clean all >> /var/log/vbupgrade.log 2>&1
			if [ $? -ne 0 ]; then
				echolog "Error: yum clean all failed; cannot do Upgrade." >> /var/log/vbupgrade.log
			else
				yum -y update --skip-broken --exclude="httpd vb-GUI vortexbox">> /var/log/vbupgrade.log 2>&1
				if [ $? -ne 0 ]; then
					echolog "Error: yum update failed. Check error messages and try to fix problems." >> /var/log/vbupgrade.log
				else
					lastline=$(tail -1 /var/log/vbupgrade.log)
					if [ "$lastline" = "No Packages marked for Update" ]; then
						/opt/vortexbox/vbcleanup.sh
						echolog "Upgrade complete. No need to reboot; nothing was updated." >> /var/log/vbupgrade.log
						continue
					else
						/opt/vortexbox/vbcleanup.sh
						echolog "Upgrade complete. Please reboot your VortexBox." >> /var/log/vbupgrade.log
					fi
				fi
			fi
		else
			echolog "VortexBox repository not available. Upgrade could not start." >> /var/log/vbupgrade.log
			echolog "Please try again later." >> /var/log/vbupgrade.log
		fi
	else
		echolog "Cannot ping google.com. Internet not available. Upgrade could not start." >> /var/log/vbupgrade.log
		echolog "(Your DNS may not be working.)" >> /var/log/vbupgrade.log
	fi
	;;

 Install )
	echo "Install"
	if ping -c 1 -w 5 "google.com" &>/dev/null ; then
	  /opt/vortexbox/package-scripts/install-$PACKAGE.sh
	else
	  echolog "Cannot ping google.com. Internet not available. Package could not be installed." >> /var/log/vbupgrade.log
	  echolog "(Your DNS may not be working)" >> /var/log/vbupgrade.log
	fi	  
	;;
 
 Delete )
	echo "Delete"
	/opt/vortexbox/package-scripts/delete-$PACKAGE.sh
	;;		
	
 RestartVBplayer )
	echo "RestartVBplayer"
	rm -rf /etc/vortexbox-player/mpd*
	/usr/bin/php /opt/vortexbox/mpd_config.php
	;;
	
 RestartDLNA )
	echo "RestartDLNA"
	cp /var/tmp/minidlna.conf /etc
	/sbin/service minidlna stop
	rm -rf /var/cache/minidlna/	
	sleep 2
	/sbin/service minidlna start
	;;
 
 RescanDLNA )
	echo "RescanDLNA"
	/sbin/service minidlna stop
	rm -rf /var/cache/minidlna/
	sleep 2
	/sbin/service minidlna start
	;;
	
 ServiceStop )
	echo "ServiceStop"
	/sbin/service $PACKAGE stop
	;;

 ServiceStart )
	echo "ServiceStart"
	/sbin/service $PACKAGE start
	;;
 
 ServiceStatus )
	/sbin/service $PACKAGE status  2> /dev/null | grep running >/dev/null 2>&1
 	if [ $? -eq 0 ]; then
	  STATUS="Running"
	else
	  STATUS="Unknown"
	fi
	/sbin/service $PACKAGE status  2> /dev/null | grep stopped >/dev/null 2>&1
 	if [ $? -eq 0 ]; then
	  STATUS="Stopped"
	fi
	echo $STATUS
	;;
	
 RAIDstatus )
	if [ -b /dev/md0 ]
	then
	 STATE=`/sbin/mdadm --detail /dev/md0 2>/dev/null| grep "State :"|awk '{ print $3 }'`
	 ACTIVE=`/sbin/mdadm --detail /dev/md0 2>/dev/null| grep "Active Devices :"|awk '{ print $4 }'`
	 FAILED=`/sbin/mdadm --detail /dev/md0 2>/dev/null| grep "Failed Devices :"|awk '{ print $4 }'`
	 echo "$STATE $ACTIVE/$FAILED (Active/Failed drives)"
	else
	 echo "0"
	fi
	;;	
 
 GetMKVconfig )
	cp /root/.MakeMKV/settings.conf /tmp
	chmod 777 /tmp/settings.conf
	;;

 PutMKVconfig )
	cp /tmp/settings.conf /root/.MakeMKV/settings.conf
	;;	
	
esac
