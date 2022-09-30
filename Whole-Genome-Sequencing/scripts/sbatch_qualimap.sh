#!/bin/bash
#SBATCH --account sduvarcall_slim	# account
#SBATCH --nodes 1					# number of nodes
#SBATCH --time 24:00:00				# max time (HH:MM:SS)

SAMP_NAME=$1 # G37-B16
qualimap bamqc -bam /work/sduvarcall/G37-2016-BRCAX-Genomes/bam_out/${SAMP_NAME}/${SAMP_NAME}.bam -nt 24 -outdir /work/sduvarcall/G37-2016-BRCAX-Genomes/qualimap/${SAMP_NAME} --java-mem-size=24G