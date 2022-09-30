#! /bin/bash
#
#SBATCH --account sduvarcall_fat		# account
#SBATCH --nodes 1						# number of nodes
#SBATCH --time 12:00:00					# max time (HH:MM:SS)

snakemake -j 999 --cores 48 -s ../../Snakefile ${1}_variants.vcf

#snakemake -j 999 --cores 48 --rerun-incomplete -s ../../Snakefile ../vcf_files/${1}_raw_variants.g.vcf ${1}_coverage_codingexons ${1}_HS_Metrics.txt