WHAT THIS IS
------------

These are some files I've modified and created for a better VortexBox experience.  Most of the changes are Web UI related; i.e. changes to  

- CSS
- HTML templates (TPL)
- icon images
- PHP files
- bash scripts for mirroring  

My hope is that with a better HTML, the Web UI will be easier to parse for an Android or iPhone app.  Also, I've added an option to mirror FLAC to Ogg Vorbis to the Web UI, and made the scripts (e.g. flac2ogg.sh and flac-ogg-mirror) to do so. Some things can be improved, so I'm putting this here so others can help fork parts of VortexBox to include new options and a better user experience.

HOWTO
------

To use these modifications, you'll need to move the files where they belong on your VortexBox.  A directory structure has already been setup; you can probably use "cp -R /path/to/VortexBox-Mods /" to overwrite the old files, and use "yum reinstall vortexbox vb-GUI" if you are unhappy with the changes. 

Note that updating vb-GUI and vortexbox will overwrite these files.  I have disabled updating those files in the Web UI.

TODO
----

- Fix flac to ogg vorbis mirroring for special characters in file names (e.g. '?,()[] etc).
- Add option to remux and transcode from MKV to AVI
- Quality selectors for mp4 and eventually avi mirroring
- Make script to add and remove these changes to get back to the original
- Add install/delete scripts for webmin, serviio, etc

AUTHORS
-------

Original code by `Andrew Gillis` et al (C) `vortexbox.org`_ GPLv3
Changes and new scripts made by `divreg`_ GPLv3 or later

.. _vortexbox.org site: http://vortexbox.org
.. _Andrew Gillis mailto:andrew@vortexbox.org
.. _divreg mailto:wyatt.brege@gmail.com
