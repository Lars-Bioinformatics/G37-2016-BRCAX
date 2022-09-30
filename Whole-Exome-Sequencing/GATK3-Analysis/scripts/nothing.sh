#! /bin/bash
#
#SBATCH --account sduvarcall_slim		# account
#SBATCH --nodes 1						# number of nodes
#SBATCH --time 2:00:00					# max time (HH:MM:SS)

snakemake -j 999 --cores 48 -s ../../Snakefile nothing.txt