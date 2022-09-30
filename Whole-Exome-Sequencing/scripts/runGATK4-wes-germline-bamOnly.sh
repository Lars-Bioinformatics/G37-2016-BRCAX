snakemake -j 999 -s /work/sduvarcall/exome_analysis/snakefile-gatk4-wes-germline-bamOnly --cores 48 --cluster "sbatch -A 'sduvarcall_slim' -p 'slim' -n 24 -t 24:00:00"
