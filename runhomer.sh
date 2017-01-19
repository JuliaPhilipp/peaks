# -S /bin/bash

set -e

INPUT="/campusdata/juphilip/results/imp3/clipper_test/5p/merged_5p_clipper_peaks.bed

# get fasta 
bedtools getfasta -fi /campusdata/juphilip/datasets/human_annotation/ucsc/Homo_sapiens/UCSC/hg19/Sequence/WholeGenomeFasta/genome.fa -bed $INPUT -fo $INPUT.fasta

# make dir for homer results
mkdir /campusdata/juphilip/results/motif/homer/clipper_5p/  
mkdir /campusdata/juphilip/results/motif/homer/clipper_5p/homer_4_6
mkdir /campusdata/juphilip/results/motif/homer/clipper_5p/homer_6_8

#run homer with	two different lengths

findMotifs.pl $INPUT.fasta fasta /campusdata/juphilip/results/motif/homer/clipper_5p/homer_4_6 -len 4,6

findMotifs.pl $INPUT.fasta fasta /campusdata/juphilip/results/motif/homer/clipper_5p/homer_6_8 -len 6,8

exit
