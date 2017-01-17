#!/bin/bash
#$ -l h_vmem=30G
#$ -m bes
#$ -pe smp 4
#$ -cwd
#$ -e error.txt
#$ -o out.txt


mkdir ./output

set -e

JAMM="/afs/cats.ucsc.edu/users/c/juphilip/software/jamm/JAMM.sh"
CHR_LENGTH="/afs/cats.ucsc.edu/users/c/juphilip/datasets/human_annotation/chromsize.txt"
# ANNOTATION="/data/ohler/Julia/annotation/mergedannotationX+.bed"
MODE="normal"
INPUT="/afs/cats.ucsc.edu/users/c/juphilip/datasets/imp3/panc1/bedfiles"
OUTPUT="/afs/cats.ucsc.edu/users/c/juphilip/datasets/imp3/panc1/bedfiles"
BIN="30"
# BACKGROUND="/data/ohler/Julia/CG6422/bedfiles/ChrX/background/plus/CG6422_INPUT_all.bed"

bash $JAMM -s $INPUT -o ./output -g $CHR_LENGTH -b $BIN -m $MODE

exit 0

