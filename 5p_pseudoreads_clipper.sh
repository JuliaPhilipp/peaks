#$ -S /bin/bash


#for i in *bam
#do bedtools bamtobed -i "$i" > "$i".bed
#done

for i in *.bed; do awk '{OFS="\t"; if($6=="+" && $2 > 14) print $1,$2-15,$2+15,$4,$5,$6; else if($6=="-" && $3>14) print $1,$3-15,$3+15,$4,$5,$6
}' "$i" > "$i".5p.bed; 
done


for i in *5p.bed; do bedToBam -i "$i" -g /campusdata/anjowall/genomes/STAR_genome_hg19/chrNameLength.txt > "$i".bam; 
done

##This produces a BAM file like this:

#ERR196190.992467       16      chr1    14639   255     30M     *       0       0       *       *
#ERR196190.627338       16      chr1    15554   255     30M     *       0       0       *       *
#ERR196190.1003286      16      chr1    15908   255     30M     *       0       0       *       *
#ERR196190.2323455      16      chr1    16300   255     30M     *       0       0       *       *
#ERR196190.1938473      16      chr1    16308   255     30M     *       0       0       *       *
#ERR196190.1196516      16      chr1    16309   255     30M     *       0       0       *       *

##From prior experience, CLIPper is expecting a sequence at least - fix like so:

for i in *5p.bed.bam
do
cat <(samtools view -H "$i") <(samtools view "$i" | awk '{OFS="\t"; print $1,$2,$3,$4,$5,$6,$7,$8,$9,"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA","FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"}') > "$i".fixed.bam
done

for i in *fixed.bam
do samtools sort -T "$i".prefix -o "$i".sorted.bam "$i"
done

for i in *sorted.bam
do
samtools index "$i"
done

for i in *.fixed.bam.sorted.bam
do
clipper -b "$i" -o "$i".peaks.bed --processors=10 -s hg19 
done

exit
#for i in *.fixed.bam.sorted.bam; do clipper -b "$i" -o "$i".premRNA.peaks.bed --processors=10 -s hg19 --superlocal --threshold-method=binomial --premRNA --bonferroni; done