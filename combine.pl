#!/usr/bin/perl
my $file1=shift;
my $file2=shift;
my $file3=shift;
open (FILE1,$file1) || die ("can't open $file1");
open (FILE2,$file2) || die ("can't open $file2");
open (FILE3,$file3) || die ("can't open $file3");
while (<FILE1>){
	chomp;
	my $feature1=$_;
	my $feature2=<FILE2>;
	chomp $feature2;
	my $feature3=<FILE3>;
	chomp $feature3;
	my $final_fea="$feature1$feature2$feature3\n";
	print $final_fea;
	}
close FILE1;
close FILE2;
close FILE3;

	
