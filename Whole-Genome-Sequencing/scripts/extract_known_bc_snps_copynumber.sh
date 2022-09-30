#!/bin/bash

WORK=/work/sduvarcall/G37-2016-BRCAX-Genomes/
#WORK=/Users/lars/Desktop/G37-BRCAX/

cd $WORK


for f in wgs_out/*vs*/WGS*vs*/ascat/*.snps.doug.combined.vcf; do
	path=`dirname $f`
	file=`basename $f`
	echo $file
	echo $path
	#intersectBed -a $path/../../tmp/tum.cn.bed -b $f --sorted > germline_analysis/${file%snps.doug.combined.vcf}.copynumber
done
