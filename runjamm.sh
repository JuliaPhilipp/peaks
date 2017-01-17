#!/bin/bash
#$ -l h_vmem=30G
#$ -m bes
#$ -pe smp 4
#$ -cwd
#$ -e error.txt
#$ -o out.txt


mkdir ./output

set -e

JAMM="/campusdata/juphilip/software/jamm/JAMM.sh"
CHR_LENGTH="/campusdata/juphilip/datasets/human_annotation/chromsize.txt"
# ANNOTATION="/campusdata/Julia/annotation/mergedannotationX+.bed"
MODE="normal"
INPUT="/campusdata/juphilip/datasets/imp3/panc1/bedfiles"
OUTPUT="/campusdata/juphilip/datasets/imp3/panc1/bedfiles"
BIN="30"
# BACKGROUND="/campusdata/Julia/CG6422/bedfiles/ChrX/background/plus/CG6422_INPUT_all.bed"

bash $JAMM -s $INPUT -o ./output -g $CHR_LENGTH -b $BIN -m $MODE

exit 0

