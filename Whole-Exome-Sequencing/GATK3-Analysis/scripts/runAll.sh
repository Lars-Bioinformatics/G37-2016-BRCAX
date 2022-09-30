#!/bin/bash

for fam_dir in */
do
	echo ${fam_dir}
	cd ${fam_dir}

	for dir in */
	do
		dir=${dir%/}
		echo ${dir}
		cd ${dir}
		#snakemake -np -s ../../Snakefile nothing.txt --unlock
		#snakemake -j 999 --cores 48 --rerun-incomplete -s ../../Snakefile --cluster-config ../../cluster.json --cluster "sbatch -A {cluster.account} -p {cluster.partition} -n {cluster.n} -t {cluster.time}" ../vcf_files/${dir}_raw_variants.g.vcf ${dir}_coverage_codingexons ${dir}_HS_Metrics.txt &
		# rm -rf 
		#mv ${dir}_recal_reads.bai ${dir}_recal.bai
		#mv ${dir}_recal_reads.bam ${dir}_recal.bam
		cd ..
	done
	cd ..
done
