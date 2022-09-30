outfile=BRCAX_combined_wgs_statistics.txt
printf "SAMPLE\t" > $outfile
sed -n '7p' G37-B10.wgs_metrics.txt >> $outfile
for f in *wgs_metrics.txt; do
	SAMPLE_NAME=${f%.wgs_metrics.txt}
	printf "${SAMPLE_NAME}\t" >> $outfile
	sed -n '8p' $f | tr '.' ',' >> $outfile
done