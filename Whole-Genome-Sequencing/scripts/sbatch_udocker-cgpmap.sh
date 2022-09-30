#!/bin/bash
#SBATCH --account sduvarcall_slim	# account
#SBATCH --nodes 1					# number of nodes
#SBATCH --time 24:00:00				# max time (HH:MM:SS)

SAMP_NAME=$1 # G37-B16
bash /work/sduvarcall/G37-2016-BRCAX-Genomes/scripts/udocker_cgpmap_sample_scripts/udocker_cgpmap_${SAMP_NAME}.sh