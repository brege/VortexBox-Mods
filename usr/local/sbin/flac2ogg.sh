#!/bin/bash
##############################################################################
# Copyright (C) 2012 divreg <wyatt.brege@gmail.com>
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
# Name: flac2ogg.sh
#
# Usage: flac2ogg.sh <flacdir> <oggopt> <oggdir>
#
# Author: Wyatt Brege <wyatt.brege@gmail.com>
# Based on work by James A. Hillyerd and
# Also based on fixes by Ron Olsen <ronolsen@comcast.net>
#
# Date: Fri May 11 2012
# Version 1.1
#
################################################################################

### Begin Configuration
# The values below will be overridden by those in ~/.flac2mp3.conf if it
# exists

# Copy artwork (*.jpg) files? Set to "true" or "false"
COPY_ARTWORK="true"

# Where we store working data (including the decoded wav file)
TMPDIR="/tmp"

# Path to flac binary
FLAC="$(which flac)"

# Path to metaflac binary (part of flac distribution)
METAFLAC="$(which metaflac)"

# Path to ogg binary 
OGGENC="$(which oggenc)"

# Maximum number of times we allow flac decode to fail per file
# before aborting
MAXFAILS=3

touch /etc/vortexbox/mirror-flac-ogg.running

# Check that we have all the required binaries
if [ ! -x "$FLAC" ]; then
  echo "ERROR: flac not installed" >&2
  yum -y --enablerepo=atrpms install flac --skip-broken
fi

if [ ! -x "$OGGENC" ]; then
  echo "ERROR: oggenc not installed" >&2
  yum -y install libogg libvorbis vorbis-tools vorbisgain --skip-broken
fi

#Were we called correctly?
if [ -z "$1" -o -z "$3" ]; then
  exit 1
fi
NOW=`date +'%m/%d/%Y %H:%M:%S'`
function echolog {
echo "`date +'%m/%d/%Y %H:%M:%S'` - $1"
}

WORK="$TMPDIR/flac2mp3.$$"
ERR="$WORK/stderr.txt"
TAGS="$WORK/track.tags"

# Get absolute directory paths
INPUTDIR="$1"
OUTPUTDIR="$3"

# Decide encoding compression level
OGGOPT="$2"

#OGGOPT="-q8"
#INPUTDIR="/storage/music/flac"
#OUTPUTDIR="/storage/music/ogg"

echo ""
echo ""
echolog "Starting FLAC to Ogg Vorbis (.ogg) mirror..."
echo ""
echolog "Input Dir: $INPUTDIR"
echolog "Output Dir: $OUTPUTDIR"
echolog "Ogg Quality: $OGGOPT"
echolog "WORK Dir: $WORK"
echo ""

# Setup work directory
rm -rf "$WORK"
if [ -e "$WORK" ]; then
  echo "Couldn't delete $WORK"
  exit 1
fi
mkdir "$WORK"
if [ ! -d "$WORK" ]; then
  echo "Couldn't create $WORK"
  exit 1
fi

# Get input file list
cd "$INPUTDIR"
OLDIFS="$IFS"
IFS=$'\n'
for filepath in $(find . -type f -name '*.flac' -print \
    | sort | sed -e 's/^\.\///' -e 's/\.flac$//'); do
  IFS="$OLDIFS"
  filedir="$(dirname "$filepath")"
  filename="$(basename "$filepath")"
  if [ ! -d "$OUTPUTDIR/$filedir" ]; then
    mkdir -p "$OUTPUTDIR/$filedir"
  fi
  
  if [ ! -f "$OUTPUTDIR/$filepath.ogg" ]; then

    # Clear tags
    rm -f "$TAGS"
    ARTIST=
    ALBUM=
    ALBUMARTIST=
    TITLE=
    DATE=
    GENRE=
    COMPOSER=
    DISCNUMBER=
    TRACKNUMBER=

    # Get tags
    $METAFLAC --export-tags-to="$TAGS" "$INPUTDIR/$filepath.flac"
    sed -i -e 'h
        s/^[^=]*=//
        s/"/\\"/g
        s/\$/\\$/g
        s/^.*$/"&"/
        x
        s/=.*$//
        y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/
        G
        s/\n/=/' "$TAGS"
    source "$TAGS"

		echolog "########################################"
		echo "Encoding $TITLE"
		echo "Artist: $ARTIST"
		echo "Album: $ALBUM ($DATE)"
		echo "AlbumArtist: $ALBUMARTIST"
		echo "Composer: $COMPOSER"
		echo "DiscNumber: $DISCNUMBER"
		echo "Track#: $TRACKNUMBER"
		echo "Genre: $GENRE"
		echo "Command executed: oggenc \"$INPUTDIR/$filepath.flac\" \"$OGGOPT\" \"$OUTPUTDIR/$filepath.ogg\""
		echo ""
	
    # Encode Ogg
    oggenc "$INPUTDIR/$filepath.flac" "$OGGOPT" "$OUTPUTDIR/$filepath.ogg" >/dev/null 2>&1

    if (( $? )); then
      echo "ERROR: encoding failed, continuing"
      echo ""
      rm -f "$OUTPUTDIR/$filepath.ogg"
      continue
    fi

#   Only copy existing coverart to cover.jpg
    if [ -f "$INPUTDIR/$filedir/cover.jpg" ]; then         
		 cp -r "$INPUTDIR/$filedir/cover.jpg" "$OUTPUTDIR/$filedir/cover.jpg"
		 if (( $? )); then
			 echo "ERROR: Adding cover art failed, continuing"
			 echo ""
			 rm -f "$OUTPUTDIR/$filedir/cover.jpg"
			 continue
		 fi
    fi
    echo ""
  fi
done

# Clean up
rm -rf "$WORK"

echo ""
echolog "FLAC to Ogg Vorbis (.ogg) mirror complete."
echo ""
rm /etc/vortexbox/mirror-flac-ogg.running
exit
