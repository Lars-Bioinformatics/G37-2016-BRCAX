__title__ = "Pipeline for Somatic Variant Calling with Mutect2"
__author__ = "Lars Andersen <larsmew@gmail.com>"
__date__ = "25/05/2017"
__version__ = "1.0"

import time
import os

#########################################################
####                       Input                     ####
#########################################################
# Somatic matched samples information
configfile: "../somatic_matched_samples.yaml"

# Sample information
FAMNAME = os.getcwd().rsplit("/",1)[1]

# Explicit paths for external input files
ref = "/work/sduvarcall/bwa-0.7.13/reference/human_g1k_v37_decoy.fasta"
dbsnp = "/work/sduvarcall/knownSNPs/dbsnp_150.b37.vcf.gz"
cosmicCoding = "/work/sduvarcall/cosmic/CosmicCodingMuts.vcf.gz"
cosmicNonCoding = "/work/sduvarcall/cosmic/CosmicNonCodingVariants.vcf.gz"


#########################################################
####                      Output                     ####
#########################################################
log_file = "log_file_somatic.txt"
output_somatic = "somatic_variants"


#########################################################
####                       Setup                     ####
#########################################################
# Timing
totim = time.time()
timeFormat = "%Y_%m_%d:%X" # year, month, day, time H:M:S

# Memory
mem = "-Xmx8g" # login nodes - be careful not running too many jobs at once!
#mem = "-Xmx24g" # slim nodes
#mem = "-Xmx32g" # Fat nodes

# Define chromosomes - perhaps implement function to extract from reference
CHROM = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13",
         "14", "15", "16", "17", "18", "19", "20", "21", "22", "X", "Y", "MT"]


#########################################################
####  Define workflow start, stop and error actions  ####
#########################################################
onstart:
	shell("echo $(head /work/sduvarcall/exome_analysis/pipeline_version.txt -n 1) >> {log_file}")
	shell("echo 'Started execution of pipeline:' $(date +'%Y-%m-%d %H:%M:%S') >> {log_file}")
	shell("mkdir -p "+output_somatic)

onsuccess:
	fiTime = 'Total time:', str((time.time()-totim) / 60), 'minutes'
	shell("echo 'Finished execution on' $(date +'%Y-%m-%d %H:%M:%S') >> {log_file}")
	shell("echo Execution time: {fiTime} >> {log_file}")
	shell("cat {log_file} >> log_file_somatic_success.txt")

onerror:
	fiTime = 'Total time:', str((time.time()-totim) / 60), 'minutes'
	shell("echo 'Finished execution on' $(date +'%Y-%m-%d %H:%M:%S') >> {log_file}")
	shell("echo Execution time: {fiTime} >> {log_file}")
	shell("echo 'ERROR OCCURED, PLEASE REFER TO SLURM LOGFILE FOR DETAILS' >> {log_file}")
	shell("cp {log_file} log_file_somatic_error.txt")

'''
Rule all
'''
PAIRS = config["fam"+FAMNAME]
print(PAIRS)
rule all:
	input:
		[expand(output_somatic+"/{normal}_vs_{tumor}_somatic_variants.vcf",
			normal=PAIRS[pair]["normal"],
			tumor=PAIRS[pair]["tumor"]) for pair in PAIRS]
		
#########################################################
####       Call Somatic Variants using Mutect2       ####
####             on per chromesome basis             ####
#########################################################
'''
Mutect
'''
rule mutect2:
	input:
		normal="{normal}_recal.bam",
		tumor="{tumor}_recal.bam",
		dbsnp={dbsnp},
		cosmicCoding={cosmicCoding},
		cosmicNonCoding={cosmicNonCoding}
	output:
		vcf=output_somatic+"/{normal}_vs_{tumor}_somatic_variants_{chrom}.vcf"
	threads: 8
	shell:
		"GenomeAnalysisTK {mem} \ "
		"-T MuTect2 \ "
		"-R {ref} \ "
		"-I:tumor {input.tumor} \ "
		"-I:normal {input.normal} \ "
		"--dbsnp {dbsnp} \ "
		"--cosmic {cosmicCoding} \ "
		"--cosmic {cosmicNonCoding} \ "
		"-nct {threads} \ "
		"-L {wildcards.chrom} \ "
		"-o {output.vcf} "


#########################################################
####           Combine VCFs files into one           ####
#########################################################
rule combineVCFs:
	input:
		vcfs=expand(output_somatic+"/{{normal}}_vs_{{tumor}}_somatic_variants_{chrom}.vcf", chrom=CHROM)
	output:
		vcf=output_somatic+"/{normal}_vs_{tumor}_somatic_variants.vcf"
	params:
		vcfs=lambda wildcards: expand("-V "+output_somatic+"/"+wildcards.normal+"_vs_"+
		                       wildcards.tumor+"_somatic_variants_{chrom}.vcf", chrom=CHROM)
	shell:
		"GenomeAnalysisTK \ "
		"-T CombineVariants \ "
		"-R {ref} \ "
		"{params.vcfs} \ "
		"-o {output} \ "
		"-genotypeMergeOptions UNIQUIFY "


# rule old_mutect2:
# 	input:
# 		normal="{normal}_recal.bam",
# 		tumor="{tumor}_recal.bam",
# 		dbsnp={dbsnp},
# 		cosmicCoding={cosmicCoding},
# 		cosmicNonCoding={cosmicNonCoding}
# 	output:
# 		vcf=output_somatic+"/{normal}_vs_{tumor}_somatic_variants.vcf"
# 	threads: 8
# 	shell:
# 		"GenomeAnalysisTK {mem} \ "
# 		"-T MuTect2 \ "
# 		"-R {ref} \ "
# 		"-I:tumor {input.tumor} \ "
# 		"-I:normal {input.normal} \ "
# 		"--dbsnp {dbsnp} \ "
# 		"--cosmic {cosmicCoding} \ "
# 		"--cosmic {cosmicNonCoding} \ "
# 		"-nct {threads} \ "
# 		"-o {output.vcf} "
