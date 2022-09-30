for fam_dir in 0*/; do
	cd ${fam_dir}
	echo ${fam_dir}
	rm -rf {log_file_somatic*, slurm-79*} somatic_variants 
	sbatch ../sbatch_somatic.sh
	#snakemake -j 999 -s ../somatic-snakefile --cores 48 --cluster-config ../cluster.json --cluster "sbatch -A {cluster.account} -p {cluster.partition} -n {cluster.n} -t {cluster.time}" &
	#snakemake -j 999 -s ../somatic-snakefile --unlock
	cd ..
done
