#!/bin/bash

function die {
  echo "$1"
  exit 1
}

d2s_character_location="$(cat /etc/diablo-2-tools/char-selected.conf)"

if [ ! -f "$d2s_character_location" ] ; then
  die 'ERROR: your toon does not seem to exist.'
fi

num=1
while [ -f /var/cache/diablo-2-tools/$num.d2s ] ; do
  let num++
done
cp -i "$d2s_character_location" /var/cache/diablo-2-tools/$num.d2s || die 'copying your character to backups FAILED'
echo 'Back-up success!'
echo "/var/cache/diablo-2-tools/$num.d2s"
