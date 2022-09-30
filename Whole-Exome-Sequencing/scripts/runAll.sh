#!/bin/bash

for fam_dir in 0*/
do
	echo ${fam_dir}
	cd ${fam_dir}
	#bash ../runGATK4-wes-germline.sh &
	bash ../runGATK4-wes-somatic.sh &
	#snakemake -np -s ../../exome_analysis/snakefile-gatk4-wes-somatic --unlock
	cd ..
done
