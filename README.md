# HSS-bin
  
## INTRODUCTION   
  
HSS-bin is an unsupervised metagenomic binning method based on hybrid sequence feature recognition and spectral clustering. This program is running by Matlab and calling a perl script during the process.  
  
## Operating environment and dependent software
  
HSS-bin is running by Matlab for Windows operating system. Additionally, perl is the dependent software, your computer must has installed perl.    
    
## Usage of HSS-bin
  
Open the command window of Matlab and input:  
>HSSbin  
>Please input your sequencing filename: # input the fasta format filename  
>Please input your number of bins: # input a number  
  
HSS-bin executes the binning by the hybrid feature with tetra-nucleotide composition and tetra-nucleotide ICO by default. If you want do the binning job with the other kinds of combinations or single feature, you can use the perl scripts new_feature_stat_nohead.pl and combine.pl to calculate the sequence feature, and then do spectral clustering with this feature. The operation steps are detailed in the HSS-bin script.
  
## Output of HSS-bin
  
The file binning_result is the clustering result for the fragments. And the file total_time is the running time of this binning operation.
  
