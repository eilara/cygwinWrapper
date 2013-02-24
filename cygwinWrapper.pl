#!/usr/bin/perl

use strict;
use warnings;

my ($command, $spec, @args) = @ARGV;

$command =~ s/\s+$//;
my $i    = 0;
my %spec = map { $_ => 1 } split /:/, "0:$spec";
my $cli  = join(' ', map { chomp; qq{"$_"} }
                     map { $spec{++$i}? cygpath($_): $_ }
                     @args
               );
$cli = qq{$command $cli};

die "Can't find command [$command]" unless -e $command;

print "# Starting command [$cli]\n";
system($cli) && die "Failed running command [$cli]";
print "# Completed command [$cli]\n";

sub cygpath { `cygpath "$_[0]"` }

