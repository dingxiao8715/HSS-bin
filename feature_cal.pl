#!/usr/bin/perl
use strict;
use warnings;

`perl new_feature_stat_nohead.pl -f sequence.fa -kc 4 -kr 4 -krh 1 -krt 3 -model 1,1,0 -o tmp4k_13.txt`;
`perl new_feature_stat_nohead.pl -f sequence.fa -kr 4 -krh 3 -krt 1 -kb 4 -kbh 3 -kbt 1 -model 0,1,1 -o tmp31.txt`;
`perl new_feature_stat_nohead.pl -f sequence.fa -kr 4 -krh 2 -krt 2 -kb 4 -kbh 2 -kbt 2 -model 0,1,1 -o tmp22.txt`;
`perl combine.pl tmp4k_13.txt tmp31.txt tmp22.txt > hybrid.txt`;
