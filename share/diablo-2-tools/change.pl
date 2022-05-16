use warnings;
use strict;
use feature 'say';
use File::Copy;

if(scalar(@ARGV) == 0){
  die 'we need some sort of input to what needs to be changed.';
}

my %changes = ();
for my $i(0 .. $#ARGV){
  my @changes = $ARGV[$i] =~ m#^@([0-9]+)make([0-1]{8})$#;
  if(scalar(@changes) != 2){
    die 'invalid input';
  }
  $changes{$changes[0]} = $changes[1];
  say 'making changes (', $changes[1], ') to address ', $changes[0];
}

#get d2s location
open my $CONFIG_FH, '</etc/diablo-2-tools/char-selected.conf' or die $!;
my $D2sDataFile = <$CONFIG_FH>;
close $CONFIG_FH;
my $D2sRevertFile = '/var/cache/diablo-2-tools/revert.d2s';

if(! -f $D2sDataFile){
  die "$D2sDataFile does not exist! What do you want to change?";
}
if(-f $D2sRevertFile){
  say "the backup file $D2sRevertFile already exists. retaining this version."
  say 'delete this file if you want this script to backup your current d2s file.'
}
else{
  say 'Saving d2s file to ', $D2sRevertFile;
  copy($D2sDataFile, $D2sRevertFile);
}

my $all;
{
  local $/;
  open(my ${f}, '<', $D2sDataFile) or die $!;
  $all = <$f>;
  close(${f});
}

#say 'in file checksum: ', +(unpack('H8', &get_actual_checksum()))[0];
#say 'my checksum:      ', +(unpack('H8', &get_your_checksum()))[0];
say 'in file checksum: ', uc(&get_actual_checksum());
say 'my checksum:      ', sprintf('%08X', &get_your_checksum());

my @all_chars = unpack('C*', $all);
while(my ($loc,$value) = each(%changes)){
  say "Location $loc changing to $value from ", sprintf('%08b', $all_chars[$loc]);
  $all_chars[$loc] = &bin($value);
}
$all = pack('C*', @all_chars);
my $chksum = &get_your_checksum();
say 'new checksum:      ', sprintf('%08X', $chksum);
@all_chars = unpack('C*', $all);
@all_chars[12 .. 15] = (
  ($chksum & 0xff00_0000) >> 24,
  ($chksum & 0xff0000) >> 16,
  ($chksum & 0xff00) >> 8,
  $chksum & 0xff  
);
$all = pack('C*', @all_chars);
{
  open(my ${f}, '>', $D2sDataFile) or die $!;
  syswrite(${f}, $all) or die $!;
  close(${f});
}

sub get_actual_checksum(){
  #say +(unpack('H32', $all))[0];
  #return pack('H*', substr((unpack('H32', $all))[0], 24, 8));
  return unpack('H*', substr($all, 12, 4));
}

sub get_your_checksum(){
  my $c = 0;
  my $addr = 0;
  my @cs = unpack('C*', $all);
  for my $ct(@cs){
    $ct += $c >> 31 & 1;
    $c = (($addr >> 2 == 3) ? 0 : $ct) + ($c << 1);
    $addr++;
  }
  return ($c & 0xff000000) >> 24 | ($c & 0xff0000) >> 8 | ($c & 0xff00) << 8 | ($c & 0xff) << 24;
}

sub bin{
  return oct('0b' . $_[0]);
}
