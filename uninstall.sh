#!/bin/bash


echo 'here we go!'
for i in bin/*; do
  rm /usr/$i || {
    echo you gotta run this script as root or this project is 0 percent installed
    exit 1
}
done

rm -fr /usr/share/diablo-2-tools
rm /etc/diablo-2-tools/char-selected.conf
rmdir /etc/diablo-2-tools
rm -fr /var/cache/diablo-2-tools
