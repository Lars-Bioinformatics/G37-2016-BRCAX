import glob
import os

# test dirs
inputDirs = ["."]

option = 1 # 1,2

# Rename:
# G37-T44_illumina-truseq-genome_H2HCKDSXX_S66_R2_001.fastq.gz ->
# G37-T44_illumina-truseq-genome_H2HCKDSXX_R2.fastq.gz
if option == 1:
	for directory in inputDirs:
		for filename in glob.iglob(directory+'/*001.fastq.gz'):
			print filename
			fs = filename.split("_")
			new_name = fs[0]+"_"+fs[1]+"_"+fs[2]+"_"+fs[4]+".fastq.gz"
			print new_name
			os.system("mv "+filename+" "+new_name)

# Rename:
# G37-T44_illumina-truseq-genome_H2HCKDSXX_R2.fastq.gz ->
# G37-T44_illumina-truseq-genome_H2HCKDSXX_2.fastq.gz
if option == 2:
	for directory in inputDirs:
		for filename in glob.iglob(directory+'/*.fastq.gz'):
			fs = filename.split("_")
			new_name = fs[0]+"_"+fs[1]+"_"+fs[2]+"_"+fs[3].replace("R","")+".fastq.gz"
			print new_name
			os.system("mv "+filename+" "+new_name)
