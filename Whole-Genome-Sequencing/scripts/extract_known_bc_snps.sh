#!/bin/bash

WORK=/work/sduvarcall/G37-2016-BRCAX-Genomes/germline_analysis
#WORK=/Users/lars/Desktop/G37-BRCAX/germline_analysis

cd $WORK


echo 'Sample_germline Mutated_snps' > doug.mutated_snps.txt
echo 'Sample_germline Mutated_snps' > doug_best.mutated_snps.txt
echo 'Sample_germline Mutated_snps' > doug_new.mutated_snps.txt
for f in ../wgs_out/*vs*/WGS*vs*/caveman/*snps.ids.annot.vcf.gz; do
	# Doug combined 107 best snps and 65 new snps
	tabix -h -R knownBCACsnps/doug_germline_snps_combined.txt $f > ${f%.ids.annot.vcf.gz}.doug.combined.vcf
	num_snps=`tabix -R knownBCACsnps/doug_germline_snps_combined.txt $f | wc -l`
	echo `basename $f` $num_snps >> doug.mutated_snps.txt
	
	# Doug 107 best snps
	tabix -h -R knownBCACsnps/doug_best.txt $f > ${f%.ids.annot.vcf.gz}.doug.best.vcf
	num_snps=`tabix -R knownBCACsnps/doug_best.txt $f | wc -l`
	echo `basename $f` $num_snps >> doug_best.mutated_snps.txt
	
	# Doug 65 new snps
	tabix -h -R knownBCACsnps/doug_new.txt $f > ${f%.ids.annot.vcf.gz}.doug.new.vcf
	num_snps=`tabix -R knownBCACsnps/doug_new.txt $f | wc -l`
	echo `basename $f` $num_snps >> doug_new.mutated_snps.txt
done

echo 'Sample_somatic Mutated_snps' > doug.mutated_somatic_snps.txt
for f in ../wgs_out/*vs*/WGS*vs*/caveman/*annot.muts.vcf.gz; do
	# Doug combined 107 best snps and 65 new snps
	##tabix -h -R $WORK/knownBCACsnps/doug_germline_snps_combined.txt $f > ${f%.ids.annot.vcf.gz}.doug.combined.vcf
	num_snps=`tabix -R knownBCACsnps/doug_germline_snps_combined.txt $f | wc -l`
	echo `basename $f` $num_snps >> doug.mutated_somatic_snps.txt
done







#tabix -R $WORK/doug_germline_snps_combined.txt G37-T34_vs_G37-B34.snps.ids.annot.vcf.gz
#tabix -R $WORK/doug_germline_snps_combined.txt G37-T34_vs_G37-B34.snps.ids.annot.vcf.gz | wc -l

