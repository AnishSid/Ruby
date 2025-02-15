#DONT WAISTE YOUR TIME WITH STRACE
#!/usr/bin/perl
# 
# # use as: $0 <PID>
#  
use warnings;
use strict;
use bignum;
use Config;

defined $Config{sig_name} or die "Cannot find signal names in Config";
my @sigs = map { "SIG$_" } split(/ /, $Config{sig_name});  

my $statfile = "/proc/$ARGV[0]/status";

open(S, "<", $statfile) or die "Cannot open status file $statfile";

while(<S>) {
	chomp;
	if (/^Sig(Blk|Ign|Cgt):\s+(\S+)/) {
	if (my @list = grep { oct("0x$2") & (1 << ($_ - 1)) } (1..64) ) {
	print "$1: " . join(", ", map { "$sigs[$_] ($_)" } @list) . "\n";
	}
    }
}


close(S);
