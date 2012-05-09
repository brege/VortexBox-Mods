VortexBox-Mods-1.0-1. <https://github.com/divreg>

WHAT THIS IS

These are some files I've modified for a better VortexBox experience.

Most of the changes are Web UI related; i.e. changes to  

 *CSS
 *HTML templates (TPL)
 *icon images
 *PHP files
 *various bash scripts.  

My hope is that with a better HTML, the HTML will be easier to parse for an android or iphone app. Also, I've added an option to mirror FLAC to Ogg to the Web UI, and made the scripts flac2ogg.sh and flac-ogg-mirror to do so.

To use these modifications, you'll need to move the files where they belong on your VortexBox.  A preliminary directory structure has already been setup to help. Note that updating vb-GUI and vortexbox will over write these files.  If you're unhappy with the changes, you can always do "yum reinstall vortexbox vb-GUI" at the command line.

Some things can be improved, so I'm putting this here so others can help fork parts of VortexBox to include new options and a better user experience.
