# -S /bin/bash

# divide bedfiles into plus and minus strand

set -e

JAMM="/campusdata/juphilip/software/jamm/JAMM.sh"
# ANNOTATION="mergedannotation.bed"
CHR_LENGTH="/campusdata/juphilip/datasets/human_annotation/chromsize_imp3.txt"
MODE="normal"
INPUT="/campusdata/juphilip/datasets/imp3/panc1/bedfiles/plus"
OUTPUT="/campusdata/juphilip/results/imp3/JAMM_test/f1_bin50_normal/plus/"
BIN="50"
# BACKGROUND="input.bed"

bash $JAMM -s $INPUT -o $OUTPUT -g $CHR_LENGTH -b $BIN -m $MODE -f 1,1,1


set -e

JAMM="/campusdata/juphilip/software/jamm/JAMM.sh"
CHR_LENGTH="/campusdata/juphilip/datasets/human_annotation/chromsize_imp3.txt"
MODE="normal"
INPUT="/campusdata/juphilip/datasets/imp3/panc1/bedfiles/minus"
OUTPUT="/campusdata/juphilip/results/imp3/JAMM_test/f1_bin50_normal/minus/"
BIN="50"

bash $JAMM -s $INPUT -o $OUTPUT -g $CHR_LENGTH -b $BIN -m $MODE -f 1,1,1

cd /campusdata/juphilip/results/imp3/JAMM_test/f1_bin50_normal/plus/peaks
less filtered.peaks.narrowPeak | awk -F"\t" 'BEGIN{OFS=FS}{print $1,$2,$3,$4,$7,"+",$5,$8,$9,$10}' > filtered_peaks_plus.bed

cd /campusdata/juphilip/results/imp3/JAMM_test/f1_bin50_normal/minus/peaks
less filtered.peaks.narrowPeak | awk -F"\t" 'BEGIN{OFS=FS}{print $1,$2,$3,$4,$7,"-",$5,$8,$9,$10}' > filtered_peaks_minus.bed

cd /campusdata/juphilip/results/imp3/JAMM_test/f1_bin50_normal
cat plus/peaks/filtered_peaks_plus.bed minus/peaks/filtered_peaks_minus.bed > filtered_peaks_all.bed


exit 0


