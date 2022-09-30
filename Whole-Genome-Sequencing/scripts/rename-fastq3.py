import glob
import os

# test dirs
inputDirs = ["."]

option = 2 # 1,2

# Rename:
# G37-T44_illumina-truseq-genome_H2HCKDSXX_R1.fastq.gz ->
# G37-T44_illumina-truseq-genome_H2HCKDSXX_R2.fastq.gz
for directory in inputDirs:
	for filename in glob.iglob(directory+'/*.fastq.gz'):
		fs = filename.split("_")
		new_name = fs[0]+"_"+fs[1]+"_S2FLOWCELL_"+fs[3]
		print new_name
		os.system("mv "+filename+" "+new_name)
