#!/bin/bash

#SBATCH --account sduvarcall_slim	# account
#SBATCH --nodes 1			# number of nodes
#SBATCH --time 24:00:00			# max time (HH:MM:SS) - must be 24:00:00 or lower

snakemake -j 999 --cores 48 -s ../somatic-snakefile
