###!/bin/python env
import os

#SAMPLES=[3,7,8,9,10,11,12,13,14,16,17,18,19,21,22,23,24,25,31,32,33,34,35,36,37,38,39,40,41,42,43,45,46,47]
SAMPLES=[7,9,10,11,12,14,16,17,18,19,22,23,24,25,31,32,34,35,36,37,38,39,40,41,42,43,45,46,47]

WORK="/work/sduvarcall/G37-2016-BRCAX-Genomes/"


for sample in SAMPLES:
	samples_bt = "G37-B" + str(sample) + "_vs_G37-T" + str(sample)
	samples_tb = "G37-T" + str(sample) + "_vs_G37-B" + str(sample)
	tum_bed = WORK + "wgs_out/" + samples_bt + "/tmp/tum.cn.bed"

	vcf = WORK + "wgs_out/" + samples_bt + "/WGS_" + samples_tb + "/caveman/" + samples_tb + ".snps.doug.combined.vcf"
	if os.path.isfile(vcf) and os.path.isfile(tum_bed):
		cmd = "intersectBed -a " + tum_bed + " -b " + vcf + " -sorted > " + WORK + "germline_analysis/" + samples_tb + ".major.copynumber"
		print(cmd)
		os.system(cmd)

		ascat_file = WORK + "wgs_out/" + samples_bt + "/WGS_" + samples_tb + "/ascat/G37-T"+str(sample)+".copynumber.caveman.csv"
		minor_cnv_bed = WORK + "germline_analysis/" + samples_tb + ".minor.copynumber.bed"
		#os.system("cut -d , -f 2,3,4,8 "+ ascat_file +" | tr ',' '\t' > " + minor_cnv_bed)
		cmd_minor_cnv = "cut -d , -f 2,3,4,8 "+ ascat_file +" | tr ',' '\t' | intersectBed -a stdin -b " + vcf + " -sorted > " + WORK + "germline_analysis/" + samples_tb + ".minor.copynumber"
		print(cmd_minor_cnv)
		os.system(cmd_minor_cnv)
		
		# cmd2 = "Rscript " + WORK + "germline_analysis/plot_snp_copynumber.R " + WORK + "germline_analysis/" + samples_tb + ".copynumber &"
		# print(cmd2)
		# os.system(cmd2)
