% Input the necessary parameters for binning
filename = input('Pleasr input your sequencing filename:','s');
bin_num = input('Pleasr input your number of bins:');
% Calculate the hybrid feature vectors 
movefile (filename,'sequence.fa');
perl ('feature_cal.pl');
clear ans;
% Do the spectral clustering
load 'hybrid.txt';
gen_nn_distance(hybrid, 50, 10, 0);
load 50_NN_sym_distance.mat;
[cluster_labels total_time] = sc(A, 0, bin_num);
movefile ('sequence.fa',filename);
binning_result = cluster_labels;
% Delete the intermediate files
clear cluster_labels;
clear filename;
clear A;
clear hybrid;
clear bin_num;
delete 50_NN_sym_distance.mat;






