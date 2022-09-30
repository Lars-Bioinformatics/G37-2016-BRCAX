#! /bin/bash

for dir in */
do
	dir=${dir%/}
	echo ${dir}
	cd ${dir}
	bash ../../clean.sh
	snakemake -np -s ../../Snakefile nothing.txt --unlock
	#snakemake -j 999 --cores 48 --rerun-incomplete -s ../../Snakefile --cluster-config ../../cluster.json --cluster "sbatch -A {cluster.account} -p {cluster.partition} -n {cluster.n} -t {cluster.time}" ../vcf_files/${dir}_raw_variants.g.vcf ${dir}_coverage_codingexons ${dir}_HS_Metrics.txt &
	# rm -rf
	sbatch ../../sbatch_haplotypeCaller.sh ${dir}
	cd ..
done
