================================
Diablo II Tools! Version 2.0 (2022)
"Who needs a character editor when you got scripts?"
TARGET: linux + wine or windows + cygwin
VERSIONS of Diablo II TARGET: single-player Diablo II non-Resurrected and probably Resurrected LoD 1.14d/1.15
HOW WELL TESTED: 2% tested, this release was super rushed
                 0% tested on windows
                 I apologize already.
================================

<linux assumption>
you're using wine to run Diablo II in ~/.wine or $WINEPREFIX installed somewhere in drive_c directory within that WINE configuration directory

YOU DO NOT NEED DIABLO II RUNNING to use these scripts.
Surely you'd want to exit out of your character in-game before editing its save D2S file.

<CAUTION>
the scripts in ./bin/ and ./share/diablo-2-tools will fail unless installed.

<WINDOWS>
install cygwin to get a linux environment + linux terminal (all installed by default). The install exe is on their website.
select to install cygwin perl5 package when you install cygwin
install golang with the Windows installer on their website. The installer automatically adds the win32/win64/whatever `go` command to your system %PATH%
  environmental variable. Cygwin inherits the Windows 10/11 %PATH% in its own $PATH and can run Win32/Win64 programs within that environmental variable
  string/code/thing.
The go script this project uses assumes your Cygwin installation is on C:\ at C:\cygwin64
Now to run Diablo II tools you just fire up your GUI terminal (which should be available as a shortcutted program on your Desktop) and you're ready
  to install this project, install it, and use it just like in linux.
NOTE: if you download this project's ZIP file you'll want to copy the ZIP file to C:\cygwin64\home\YourWindowsUsername\
      through the Windows explorer. That way you can unzip the file in Windows explorer, cd to the directory in your Cygwin terminal,
      and install/use as-usual

<TO_INSTALL_USE>
just go:  sudo bash install.sh #in Linux tty/terminal
just go:  bash install.sh #in Cygwin terminal on Windows
Now you can use all of my tools, YAAAAyyyyy

<TO_PURGE_FROM_SYSTEM>
(ie. to uninstall)
just go:  sudo bash uninstall.sh #in Linux tty/terminal
just go:  bash uninstall.sh #in Cygwin terminal on Windows

<FAQ>
- Where does this program target D2S files at?
when you call d2-charselect-Safe.sh or d2-toonselect-Safe.sh (they're the same thing)
all of your .d2s files within C:\Users (on Windows) or $WINEPREFIX/drive_c/users (on Linux if $WINEPREFIX exists)
                                                    or ~/.wine/drive_c/users (on Linux if $WINEPREFIX doesn't exist)
Then you can type the full path of the .d2s file and hit ENTER and now all of the diablo-2-tools will target that .d2s save file!

What these tools lack:
1) a way to edit stats (str, dex, health points, mana points)
2) a way to edit item stats (although you can download d2s files and save the item codes for injecting into any character)
3) a way to revive your character if your character dies in hardcore
4) a way to get the cow portal if you killed cow king
5) a way to add gold to your inventory/stash (although you could insert a Perfect Gem and then sell it)
6) a way to reset certain quests like the act 5 free-socketing quest (although you could backup your character, use the quest, save the item code for
  insertion later, and then revert your save d2s character file lol)

<requires>
golang: the `go` command
perl5: the `perl` command

<installed_files>
/usr/bin/d2-charselect-Safe.sh #edit /etc/diablo-2-tools/char-selected.conf that is used by the scripts to know which Diablo 2 character you wish to edit/read/alter
         d2-toonselect-Safe.sh #same thing as d2-charselect-Safe.sh
         d2-backupChar-Reads.sh
         d2-changeSkills-Reads.sh #the HTML file to make this process solid uses sorceress images, but the system works for all 7 characters.
         d2-insertItem-Alters.sh
         d2-makeFree-Safe.sh
         d2-renameChar-Safe.sh
         d2-showItems-Reads.sh
         d2-stam2rejuv-Reads.sh 
         man-diablo-2-tools #shows this file, which is /usr/share/diablo-2-tools/MAN_PAGE_SORTA_README.txt
/etc/diablo-2-tools/char-selected.conf
/var/cache/diablo-2-tools #this is where we put revert.d2s (change.pl generates this as an auto-backup) and #.d2s (created incrementally by d2-backupChar-Reads.sh)
/usr/share/diablo-2-tools/change.pl           #can fix the checksum and alter the hex in the character at addresses
                          change skill.html   #a helper for /usr/bin/d2-changeSkills-Reads.sh, gets viewed with basically any graphical browser like firefox
                          cold.png            #a resource for 'change skill.html'
                          fire.png            #""
                          lightning.png       #""
                          get skill data.pl   #get the current character skill data to paste into change skill.html, this is called by d2-changeSkills-Reads.sh
                          JM-find-codes.pl    #locates all of the items in the D2S character save file, this is called by d2-showItems-Reads.sh
                          print-item-location.pl  #a helper for JM-find-codes.pl that uses the item information to find where it is located
                                                  #(stash, equipment, inventory, belt, cube)
                          JM-inserter.go      #insert any perfect gem or rune or custom item code into typically the cube. this is called by d2-insertItem-Alters.sh
                                              #d2-insertItem-Alters.sh fixes the checksum by calling change.pl
                          make free.pl        #gives change.pl copy-and-paste codes. this is called by d2-makeFree-Safe.sh
                          print-JM-potions.pl #searches for stamina potions and calls stam2rejuv.pl to convert them into full rejuvs, called by d2-stam2rejuv-Reads.sh
                          rename-toon.pl      #prints out the change.pl codes and a bash/terminal/tty command you can copy and paste to successfully
                                              #rename your toon/character/d2s-file, this is called by d2-renameChar-Safe.sh
                          stam2rejuv.pl       #prints out the change.pl codes to convert the stamina potions to full rejuvs
                          MAN_PAGE_SORTA_README.txt #viewed by running /usr/bin/man-diablo-2-tools


And here are the tools to execute freely:
1) d2-charselect-Safe.sh / d2-toonselect-Safe.sh
enter the d2s file you wish to target/edit with all of the tools.
Searches ~/.wine/drive_c/users/ or $WINEPREFIX/drive_c/users
for d2s files
Once you enter your d2s-file/character-data-file/toon the path gets written to /etc/diablo-2-tools/char-selected.conf
2) d2-backupChar-Reads.sh
copies the character/toon/d2s-file where's location is stored in /etc/diablo-2-tools/char-selected.conf to
  /var/cache/diablo-2-tools/a-incremented-number.d2s
3) d2-changeSkills-Reads.sh
prints out the codes from the d2s-file/toon/character where's location is stored in /etc/diablo-2-tools/char-selected.conf to copy-and-paste into
  /usr/share/diablo-2-tools/change skill.html .. launched/viewed from firefox or epiphany or konqueror or chromium or google-chrome or opera or whatever
  Then in the HTML file you press the export
  button and copy and paste that into your terminal:
  cd /usr/share/diablo-2-tools/
  perl change.pl *copy-and-paste-here*
4) d2-insertItem-Alters.sh
insert an item via the first argument sent.
be sure your cube is empty before executing this!
and if you don't have a cube..
  d2-insertItem-Alters.sh 1000800065000022f6860782251813be86e03f #adds cube to top-left inventory
                                                                 #be sure that is clear before injecting
Add a rune example:
  d2-insertItem-Alters.sh runes_El  #adds El rune to cube
  d2-insertItem-Alters.sh runes_zod #adds Zod to cube
Add a gem example:
  d2-insertItem-Alters.sh gems_a     #adds a P. amethyst to cube
  d2-insertItem-Alters.sh gems_skull #adds a P. skull to your cube
Add a coded item:
  #the following two sequentially add the viper amulet and horadric staff in the cube for
  # act 2 normal!
  d2-insertItem-Alters.sh 10008000650000d83667068210710183c8c1075a3e9ce049c1b382a7054f17e37f
  d2-insertItem-Alters.sh 100080006500606897060702f7088e34c78d3d7040450295164bff01
5) d2-makeFree-Safe.sh
can access nightmare/hell & has all waypoints.
6) d2-renameChar-Safe.sh
safely rename a character ...
d2-renameChar-Safe.sh John Sally
I believe you can also go:
d2-renameChar-Safe.sh John.d2s SallyRide #or
d2-renameChar-Safe.sh John.d2s Megatron.d2s
7) d2-showItems-Reads.sh
show the codes of the current items in stash/inventory/cube/equipped/belt.
8) d2-stam2rejuv-Reads.sh
reads all of the stamina potions inside of your character and then you paste
  the output into here:
cd /usr/share/diablo-2-tools/
perl change.pl *copy-and-paste-here*
# and that will change your toon from stamina to full rejuvs.
