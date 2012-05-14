What this is
------------

These are some files I've modified and created for a better VortexBox experience.  Most of the changes are Web UI related; i.e. changes to  

- CSS
- HTML templates (TPL)
- icon images
- PHP files
- bash scripts for mirroring  

My hope is that with a better HTML, the Web UI will be easier to parse for an Android or iPhone app.  Also, I've added an option to mirror FLAC to Ogg Vorbis to the Web UI, and made the scripts (e.g. flac2ogg.sh and flac-ogg-mirror) to do so. Some things can be improved, so I'm putting this here so others can help fork parts of VortexBox to include new options and a better user experience.

THIS IS NOT OFFICIALLY SUPPORTED SOFTWARE FOR VORTEXBOX

Howto
-----

To use these modifications, you'll need to move the files where they belong on your VortexBox.  A directory structure has already been setup; you can probably use "cp -R /path/to/VortexBox-Mods /" to overwrite the old files, and use "yum reinstall vortexbox vb-GUI" if you are unhappy with the changes. No warantees (see COPYING).

Note that updating vb-GUI and vortexbox will overwrite these files.  Updating thses packages has been disabled in this version of the Web UI.

Todo
----

- [audio] foo2bar scripts

  - fix flac to ogg vorbis mirroring for special characters in file names (e.g. '?,()[] etc).

  - use "vorbisgain" to apply replay gain to ogg vorbis files
 
  - add option to re-encode flac's to aac 320 or other bitrates 

- [video] add options for further remuxing and transcoding to different containers and audio/video/subtitle formats under various standards

  - make mkv's with x264 for smaller file size under "new scene standard"  or add an option to do so

  - add option to remux and transcode from mkv to "old scene standard" avi at /flacmirror.php

  - fix mp4 mirroring to follow "new scene stanard"

  - add option to remux and transcode from mkv to ogg (libvorbis for audio, libtheora for video) under "wikipedia standard"
  
  - quality selectors for mp4 etc mirroring

- [scripts] installing scripts

  - make script to add and remove these changes to get back to the original, official software supported by http://vortexbox.org

  - add install/delete scripts for webmin, serviio, etc

Changelog
---------

2012.05.13

- fixed flac-to-ogg when a fresh CD is ripped

- made changes to flac-to-ogg scripts over all

Authors
-------

Original code by `Andrew Gillis`_ et al (C) http://vortexbox.org GPLv3

Changes and new scripts made by `divreg`_ (C) GPLv3 or later

.. _Andrew Gillis: mailto:andrew@vortexbox.org
.. _divreg: mailto:wyatt.brege@gmail.com
