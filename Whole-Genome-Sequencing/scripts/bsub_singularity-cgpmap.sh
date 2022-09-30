#!/bin/bash
SAMP_NAME=$1
bsub -o logs/output_${SAMP_NAME}.%J -e logs/errorfile_${SAMP_NAME}.%J -n 6 -q singularity scripts/singularity-cgpmap.sh $SAMP_NAME