#$ -S /bin/bash

set -e

FILE1=$1
FILE2=$2
FILE3=$3

# concatenate all replicates
cat $FILE1 $FILE2 $FILE3 > cat_5p_clipper_peaks.bed

# sort
sortBed -i cat_5p_clipper_peaks.bed > cat_sort_5p_clipper_peaks.bed

# merge
bedtools merge -i cat_sort_5p_clipper_peaks.bed -s -c 6 -o distinct | awk '{OFS="\t"; print $1,$2,$3,"peak",1000,$4}' > merged_5p_clipper_peaks.bed

# use multicov
bedtools multicov -s -bams /campusdata/juphilip/datasets/imp3/panc1/bamfiles/panc1x_imp3d7x_jd001a_hg19.ih1.rdcb1.star.map.trk.bam -bed merged_5p_clipper_peaks.bed > multicovA_5p_clipper.tsv

bedtools multicov -s -bams /campusdata/juphilip/datasets/imp3/panc1/bamfiles/panc1x_imp3d7x_jd001b_hg19.ih1.rdcb1.star.map.trk.bam -bed merged_5p_clipper_peaks.bed > multicovB_5p_clipper.tsv

bedtools multicov -s -bams /campusdata/juphilip/datasets/imp3/panc1/bamfiles/panc1x_imp3d7x_jd001c_hg19.ih1.rdcb1.star.map.trk.bam -bed merged_5p_clipper_peaks.bed > multicovC_5p_clipper.tsv

exit