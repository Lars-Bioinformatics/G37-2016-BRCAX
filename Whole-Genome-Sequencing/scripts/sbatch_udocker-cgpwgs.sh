#!/bin/bash
#SBATCH --account sduvarcall_fat	# account
#SBATCH --nodes 1					# number of nodes
#SBATCH --time 24:00:00				# max time (HH:MM:SS)
#SBATCH --output "/work/sduvarcall/G37-2016-BRCAX-Genomes/logs_wgs/slurm-G37-B9_vs_G37-T9-%j.out"

NORMAL=$1 # G37-B16
TUMOUR=$(echo $NORMAL | tr 'B' 'T') #G37-T16
bash /work/sduvarcall/G37-2016-BRCAX-Genomes/scripts/udocker-cgpwgs.sh $NORMAL 