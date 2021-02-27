#!/usr/bin/perl

use strict;
use warnings;

open IN, "samtools view $ARGV[0]|" or die $!;
open OUT, ">$ARGV[1]" or die $!;

my %hash;

while(<IN>){
	chomp;
	my $R1 = $_;
	my @tmp = split/\t+/,$R1;
	my $barcode = substr($tmp[0],1,6);
	my $R2 = <IN>;
	chomp($R2);
	next if exists $hash{$barcode}{$tmp[2]}{$tmp[3]};
	$hash{$barcode}{$tmp[2]}{$tmp[3]}=1;
	
	print OUT "$R1\n$R2\n";
}

close IN;
close OUT;
