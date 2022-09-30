#!/bin/bash
bsub -o output.%J -e errorfile.%J -n 6 -q normal runBWA_sanger.sh 