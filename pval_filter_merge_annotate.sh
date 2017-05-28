#$ -S /bin/bash

set -e
INPUTDIR=$1
PVAL=$2
DATA=$3
FASTA="/campusdata/juphilip/datasets/human_annotation/ucsc/Homo_sapiens/UCSC/hg19/Sequence/WholeGenomeFasta/genome.fa"

for f in $INPUTDIR/*.peaks.bed
do
  FILENAME="${$f%.*}"
  cat $f | awk -F "\t" '$5 < $PVAL' > $FILENAME.filtered.$PVAL.bed

done

cat $INPUTDIR/*.filtered.$PVAL.bed > $INPUTDIR/temp1.bed

sortBed -i $INPUTDIR/temp1.bed > $INPUTDIR/temp2.bed

bedtools merge -i $INPUTDIR/temp2.bed -s -c 6 -o distinct | awk '{OFS="\t"; print $1,$2,$3,"peak",1000,$4}' > $INPUTDIR/$DATA.final_clipper.bed

bedtools getfasta -fi $FASTA -bed $INPUTDIR/$DATA.final_clipper.bed -fo $INPUTDIR/$DATA.final_clipper.fasta

annotatePeaks.pl $INPUTDIR/$DATA.final_clipper.bed hg19 -annStats $INPUTDIR/$DATA.final_clipper_annotation.txt >$INPUTDIR/$DATA.final_clipper_annotated.bed

#rename bedfile for kmer counting etc. -> fasta file has strand in name
cat $INPUTDIR/$DATA.final_clipper.bed | awk 'BEGIN{OFS="\t"}{$4=($1 ","$2 "-" $3 "," $6)}{print $1,$2,$3,$4,$5,$6}' > $INPUTDIR/$DATA.final_clipper_named.bed

bedtools getfasta -fi $FASTA -bed $INPUTDIR/$DATA.final_clipper_named.bed -name -fo $INPUTDIR/$DATA.final_clipper_named.fasta

rm $INPUTDIR/temp1.bed
rm $INPUTDIR/temp2.bed