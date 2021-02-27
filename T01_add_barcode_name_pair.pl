#!/usr/bin/perl
use strict;
use warnings;

open IN1, "gzip -dc $ARGV[0]|" or die $!;
open IN2, "gzip -dc $ARGV[1]|" or die $!;
open OUT1, "|gzip - > $ARGV[0].pair.add.fq.gz" or die $!;
open OUT2, "|gzip - > $ARGV[1].pair.add.fq.gz" or die $!;

while(<IN1>){
	my $name1= $_;
	my $name2 = <IN2>;
	my $seq1 = <IN1>;
	my $seq2 = <IN2>;
	my $mark1 = <IN1>;
	my $mark2 = <IN2>;
	my $qual1 = <IN1>;
	my $qual2 = <IN2>;
	chomp($name1);
	chomp($name2);
	chomp($seq1);
	chomp($seq2);
	chomp($mark1);
	chomp($mark2);
	chomp($qual1);
	chomp($qual2);
	my $name = "@";
	my $name_2 ; # R2 name
	$name .= ":";
	my $random = substr($seq1,0,6);
	$name .= $random;
	$name .= ":";
	$name_2 .= $name; #R2 name
	$name .= substr($name1, 1, length($name1)-1);
	$name_2 .=substr($name2, 1, length($name2)-1); #R2 name
	my $seqf1 = substr($seq1, 11);
	my $seqf2 = substr($seq2, 11);
	my $qualf1 = substr($qual1, 11);
	my $qualf2 = substr($qual2, 11);
	print OUT1 "$name\n";
	print OUT1 "$seqf1\n";
	print OUT1 "$mark1\n";
	print OUT1 "$qualf1\n";
	print OUT2 "$name_2\n";
	print OUT2 "$seqf2\n";
	print OUT2 "$mark2\n";
	print OUT2 "$qualf2\n";
}
close IN1;
close IN2;
close OUT1;
close OUT2;
