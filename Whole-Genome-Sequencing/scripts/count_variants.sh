out=variant_counts.txt
echo "Caveman counts" > $out
for f in G*; do 
	echo -e "${f}\t" >> $out
	zcat ${f}/WGS_${f}*/caveman_battenberg/*.annot.muts.vcf.gz | grep -v ^# | wc -l >> $out
	echo -e "\n" >> $out
done