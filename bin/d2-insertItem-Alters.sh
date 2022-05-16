#!/bin/bash

function die {
  echo "$1"
  exit 1
}

if [ -z "$1" ] ; then
  die 'd2-insertItem.sh 4a4d10008009239123d02'
fi

d2s_location="$(cat /etc/diablo-2-tools/char-selected.conf)"

if [ ! -f "$d2s_location" ] ; then
  die 'ERROR: your toon does not seem to exist.'
fi

cd /usr/share/diablo-2-tools || die 'ERROR: could not CD to /usr/share/diablo-2-tools'
go run JM-inserter.go "$1" || die 'JM-inserter.go FAILED' #insert the file.
perl change.pl '@5make00000000' || die 'change.pl FAILED' #fix the checksum.

