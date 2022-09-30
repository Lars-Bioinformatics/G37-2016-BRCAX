#!/bin/bash
#SBATCH --account sduvarcall_fat	# account
#SBATCH --nodes 1					# number of nodes
#SBATCH --time 24:00:00				# max time (HH:MM:SS)
#SBATCH --output "/work/sduvarcall/G37-2016-BRCAX-Genomes/exome_test/slurm-G37-01226_vs_G37-A085-%j.out"

bash /work/sduvarcall/G37-2016-BRCAX-Genomes/scripts/udocker-cgpwxs.sh