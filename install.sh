#!/bin/bash

echo 'here we go!'
chmod +x bin/*
cp bin/* /usr/bin/ || {
  echo you gotta run this as root bro
  exit 1
}

cp -R share/diablo-2-tools /usr/share/
mkdir /etc/diablo-2-tools
touch /etc/diablo-2-tools/char-selected.conf
chmod +w /etc/diablo-2-tools/char-selected.conf
mkdir /var/cache/diablo-2-tools
chmod +w /var/cache/diablo-2-tools
