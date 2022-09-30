#!/bin/bash

### MISSING
bsub -o logs/output_G37-T46.%J -e logs/errorfile_G37-T46.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-T46.sh
bsub -o logs/output_G37-T45.%J -e logs/errorfile_G37-T45.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-T45.sh
bsub -o logs/output_G37-T43.%J -e logs/errorfile_G37-T43.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-T43.sh
bsub -o logs/output_G37-T42.%J -e logs/errorfile_G37-T42.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-T42.sh
bsub -o logs/output_G37-T41.%J -e logs/errorfile_G37-T41.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-T41.sh
bsub -o logs/output_G37-T40.%J -e logs/errorfile_G37-T40.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-T40.sh
bsub -o logs/output_G37-T39.%J -e logs/errorfile_G37-T39.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-T39.sh
bsub -o logs/output_G37-T38.%J -e logs/errorfile_G37-T38.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-T38.sh
bsub -o logs/output_G37-T37.%J -e logs/errorfile_G37-T37.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-T37.sh
bsub -o logs/output_G37-T32.%J -e logs/errorfile_G37-T32.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-T32.sh
bsub -o logs/output_G37-T31.%J -e logs/errorfile_G37-T31.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-T31.sh
bsub -o logs/output_G37-T24.%J -e logs/errorfile_G37-T24.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-T24.sh
bsub -o logs/output_G37-T21.%J -e logs/errorfile_G37-T21.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-T21.sh
bsub -o logs/output_G37-T18.%J -e logs/errorfile_G37-T18.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-T18.sh
bsub -o logs/output_G37-T16.%J -e logs/errorfile_G37-T16.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-T16.sh
bsub -o logs/output_G37-T14.%J -e logs/errorfile_G37-T14.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-T14.sh
bsub -o logs/output_G37-T13.%J -e logs/errorfile_G37-T13.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-T13.sh
bsub -o logs/output_G37-T12.%J -e logs/errorfile_G37-T12.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-T12.sh
bsub -o logs/output_G37-T11.%J -e logs/errorfile_G37-T11.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-T11.sh


bsub -o logs/output_G37-B33.%J -e logs/errorfile_G37-B33.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-B33.sh
bsub -o logs/output_G37-B25.%J -e logs/errorfile_G37-B25.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-B25.sh
bsub -o logs/output_G37-B23.%J -e logs/errorfile_G37-B23.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-B23.sh
bsub -o logs/output_G37-B17.%J -e logs/errorfile_G37-B17.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-B17.sh
bsub -o logs/output_G37-B16.%J -e logs/errorfile_G37-B16.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-B16.sh
bsub -o logs/output_G37-B14.%J -e logs/errorfile_G37-B14.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-B14.sh
bsub -o logs/output_G37-B13.%J -e logs/errorfile_G37-B13.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-B13.sh
bsub -o logs/output_G37-B12.%J -e logs/errorfile_G37-B12.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-B12.sh

### RUNNING
bsub -o logs/output_G37-T7.%J -e logs/errorfile_G37-T7.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-T7.sh
bsub -o logs/output_G37-B3.%J -e logs/errorfile_G37-B3.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-B3.sh
bsub -o logs/output_G37-B7.%J -e logs/errorfile_G37-B7.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-B7.sh
bsub -o logs/output_G37-B46.%J -e logs/errorfile_G37-B46.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-B46.sh

bsub -o logs/output_G37-T35.%J -e logs/errorfile_G37-T35.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-T35.sh
bsub -o logs/output_G37-T34.%J -e logs/errorfile_G37-T34.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-T34.sh


# NOT RUNNING
bsub -o logs/output_G37-T47.%J -e logs/errorfile_G37-T47.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-T47.sh
bsub -o logs/output_G37-T10.%J -e logs/errorfile_G37-T10.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-T10.sh



bsub -o logs/output_G37-B45.%J -e logs/errorfile_G37-B45.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-B45.sh
bsub -o logs/output_G37-B39.%J -e logs/errorfile_G37-B39.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-B39.sh
bsub -o logs/output_G37-B35.%J -e logs/errorfile_G37-B35.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-B35.sh
bsub -o logs/output_G37-B34.%J -e logs/errorfile_G37-B34.%J -n 12 -q singularity -R 'span[hosts=1]' -R 'select[mem>8000]' scripts/singularity_cgpmap_sample_scripts/singularity_cgpmap_G37-B34.sh
