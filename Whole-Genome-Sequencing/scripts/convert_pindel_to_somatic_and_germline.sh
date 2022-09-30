#!/bin/bash

for f in wgs_out/*/WGS*vs*/pindel/*.annot.vcf.gz; do
#for f in wgs_out/*/WGS*vs*/pindel/G37-T10_vs_G37-B10.annot.vcf.gz; do
	filename=${f%.annot.vcf.gz}
	echo $filename
	zless $f | grep -E '^#|PASS' | bgzip -c > ${filename}.annot.somatic.vcf.gz
	tabix -p vcf ${filename}.annot.somatic.vcf.gz
	zless $f | grep -v 'PASS' | bgzip -c > ${filename}.annot.germline.vcf.gz
	tabix -p vcf ${filename}.annot.germline.vcf.gz
done