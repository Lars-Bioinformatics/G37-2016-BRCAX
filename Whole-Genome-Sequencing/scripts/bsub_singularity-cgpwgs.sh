#!/bin/bash
NORMAL=$1
TUMOUR=$(echo $NORMAL | tr 'B' 'T')
CORES=$2
#echo $NORMAL
#echo $TUMOUR
bsub -o logs_cgpwgs/output_${NORMAL}_vs_${TUMOUR}.%J -e logs_cgpwgs/errorfile_${NORMAL}_vs_${TUMOUR}.%J -n $CORES -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity-cgpwgs.sh $NORMAL $CORES