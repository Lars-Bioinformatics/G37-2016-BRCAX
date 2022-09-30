snakemake -j 999 -s /work/sduvarcall/exome_analysis/snakefile-cgpwgs --cores 24 --cluster "sbatch -A 'sduvarcall_fat' -p 'fat' -n 24 -t 24:00:00"
