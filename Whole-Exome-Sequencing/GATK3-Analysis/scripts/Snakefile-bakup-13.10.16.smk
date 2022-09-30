import time
import os
#import glob

SAMPLES, = glob_wildcards("{sample}_R1.fastq.gz")
FAMNAME = os.getcwd().rsplit("/",1)[1]
totim = time.time()

# Relative paths
# ref = "../../../bwa-0.7.13/reference/human_g1k_v37_decoy.fasta"
# bed = "../../../NimbleGen_ExomeV3_U3/NimbleGen_ExomeV3_UTR_CustomTargetRegion_padding100bp.bed"
# interval = "../../../NimbleGen_ExomeV3_U3/NimbleGen_ExomeV3_UTR_CustomTargetRegion.interval"
# dbsnp = "../../../knownSNPs/dbsnp_138.b37.vcf"
# mills_1000G = "../../../knownSNPs/Mills_and_1000G_gold_standard.indels.b37.vcf"

# Explicit paths
ref = "/work/sduvarcall/bwa-0.7.13/reference/human_g1k_v37_decoy.fasta"
bed = "/work/sduvarcall/NimbleGen_ExomeV3_U3/NimbleGen_ExomeV3_UTR_CustomTargetRegion_padding100bp.bed"
interval = "/work/sduvarcall/NimbleGen_ExomeV3_U3/NimbleGen_ExomeV3_UTR_CustomTargetRegion.interval"
dbsnp = "/work/sduvarcall/knownSNPs/dbsnp_138.b37.vcf"
mills_1000G = "/work/sduvarcall/knownSNPs/Mills_and_1000G_gold_standard.indels.b37.vcf"


timeFormat = "%Y_%m_%d:%X" # year, month, day, time H:M:S
log_file = "log_file.txt"
mem = "-Xmx32g"

'''
Create log file, containing:
	- Programs used and their version info
	- Start and stop time of complete workflow
	- sample(s)
'''
onstart:
	shell("echo 'Started execution of pipeline:' $(date +'%Y-%m-%d %H:%M:%S') >> {log_file}")

onsuccess:
	fiTime = 'Total time:', str(time.time()-totim)
	shell("echo 'Finished execution on' $(date +'%Y-%m-%d %H:%M:%S') >> {log_file}")
	shell("echo {fiTime} >> {log_file}")
	shell("cat {log_file} >> log_file_success.txt")
	#shell("mv {log_file} log_file_success.txt")

onerror:
	fiTime = 'Total time:', str(time.time()-totim)
	shell("echo 'Finished execution on' $(date +'%Y-%m-%d %H:%M:%S') >> {log_file}")
	shell("echo {fiTime} >> {log_file}")
	shell("echo 'ERROR OCCURED, PLEASE REFER TO SLURM LOGFILE FOR DETAILS' >> {log_file}")
	shell("cp {log_file} log_file_error.txt")


'''
Rule all
'''
rule all:
	input:
		#expand("../vcf_files/{sample}_raw_variants.g.vcf", sample=SAMPLES)
		expand("{sample}_coverage_codingexons", sample=SAMPLES),
		expand("{sample}_HS_Metrics.txt", sample=SAMPLES),
		expand("{fam_name}_variants.vcf", fam_name=FAMNAME)
		


'''
Map reads to reference genome with bwa (adding read groups with -R, random placeholder text)
Uses samtools to sort mappings and convert to bam file
'''
rule map_and_sort:
	input:
		ref={ref},
		faq=expand("{{sample}}_{pair}.fastq.gz", pair=["R1","R2"])
	output:
		temp("{sample}_aligned_sorted.bam")
	params:
		#rg = "@RG\tID:{sample}\tLB:NimbleGen\tPL:Illumina\tSM:{sample}\tPU:{sample}"
		rg = "@RG\tID:bwa\tLB:NimbleGen\tPL:Illumina\tSM:{sample}\tPU:{sample}"
	benchmark:
		"{sample}.bwa.benchmark.txt"
	threads: 24
	shell:
		"bwa mem -t {threads} -R '{params.rg}' {input} | samtools sort - > {output}"
		
		# Write to logfile
		" && echo 'Aligning with bwa mem and output sorted bam file with samtools' >> {log_file}"
		" && echo 'bam mem version: 0.7.15-r1140' >> {log_file}"
		" && echo 'samtools version: 1.3.1' >> {log_file}"
		" && echo 'Reference genome:' {ref} >> {log_file}"


'''
Remove duplicate reads - for faster processing later
'''
rule remove_duplicates:
	input:
		"{sample}_aligned_sorted.bam"
	output:
		temp("{sample}_aligned_sorted_reDup.bam")
	shell:
		"picard {mem} MarkDuplicates I={input} O={output} "
		"REMOVE_DUPLICATES=true METRICS_FILE=duplicate_metrics.txt"
		
		# Write to logfile
		"&& echo 'Removing PCR Duplicates' >> {log_file}"
		"&& echo 'Picard MarkDuplicates version:' $(picard MarkDuplicates --version) >> {log_file}"


'''
Creates index bai file with Samtools
'''
rule index_bam:
	input:
		"{sample}_aligned_sorted_reDup.bam"
	output:
		temp("{sample}_aligned_sorted_reDup.bam.bai")
	shell:
		"samtools index {input}"
		
		"&& echo 'Created index for reDup bam file' >> {log_file}"


'''
Obtain recalibration information
'''
rule patterns_covariation_pass:
	input:
		bam="{sample}_aligned_sorted_reDup.bam",
		bai="{sample}_aligned_sorted_reDup.bam.bai",
		mills_1000G={mills_1000G},
		dbsnp={dbsnp}
	output:
		"{sample}_recal_data.table"
	shell:
		"GenomeAnalysisTK -Xmx32g \ "
		"-T BaseRecalibrator \ "
		"-R {ref} \ "
		"-I {input.bam} \ "
		"-knownSites {input.dbsnp} \ "
		"-knownSites {input.mills_1000G} \ "
		"-cov ReadGroupCovariate \ "
		"-cov QualityScoreCovariate \ "
		# "-cov CycleCovariate \ "
		# "-cov ContextCovariate \ "
		# "-rf BadCigar \ "
		"-nct 8 \ "
		"-o {output}"
		
		# Write to logfile
		"&& echo 'Obtained covariation patterns for recalibration' >> {log_file}"
		"&& echo 'dbsnp version: dbsnp_138.b37.vcf' >> {log_file}"
		"&& echo '1000G version: Mills_and_1000G_gold_standard.indels.b37.vcf' >> {log_file}"


'''
Apply Recalibration
'''
rule apply_recalibration:
	input:
		bam="{sample}_aligned_sorted_reDup.bam",
		bai="{sample}_aligned_sorted_reDup.bam.bai",
		table="{sample}_recal_data.table"
	output:
		"{sample}_recal.bam"
	shell:
		"GenomeAnalysisTK -Xmx32g \ "
		"-T PrintReads \ "
		"-R {ref} \ "
		"-I {input.bam} \ "
		"-BQSR {input.table} \ "
		# "-rf BadCigar \ "
		"-nct 8 \ "
		"-o {output}"
		
		# Write to logfile
		"&& echo 'Recalibrate bases' >> {log_file}"
		"&& echo 'GATK version:' $(GenomeAnalysisTK --version) >> {log_file}"


'''
Depth of coverage calculation
'''
rule depth_of_coverage:
	input:
		bam="{sample}_recal.bam"
	output:
		"{sample}_coverage_codingexons"
	shell:
		"GenomeAnalysisTK -Xmx32g \ "
		"-T DepthOfCoverage \ "
		"-L {bed} \ "
		"-o {output} \ "
		#"-I {sample}.marked.realigned.recal.bam \ "
		"-I {input} \ "
		"-R {ref} \ "
		#"-geneList //data/martin/analysis/refGene_sorted_1-22xy_REDUCED.b37.txt \ "
		"--omitDepthOutputAtEachBase \ "
		"--summaryCoverageThreshold 30 \ "
		"--minBaseQuality 30"
		
		# Write to logfile
		"&& echo 'Calculate depth of coverage' >> {log_file}"
		
		"&& touch {output}" # To remove false error logs

'''
Collect Hybrid Selection metrics
'''
rule collectHsMetrics:
	input:
		bam="{sample}_recal.bam"
	output:
		"{sample}_HS_Metrics.txt"
	shell:
		"picard CollectHsMetrics -Xmx10g BAIT_INTERVALS={interval} "
		"TARGET_INTERVALS={interval} INPUT={input} OUTPUT={output} REFERENCE_SEQUENCE={ref}"
		
		# Write to logfile
		"&& echo 'Collect Hybrid Selection metrics' >> {log_file}"


'''
Rule to create directory for VCF files		
'''
rule create_vcf_dir:
	output:
		"gvcf_files"
	shell:
		"mkdir {output} && echo 'Created gvcf dir'" # For output file info

'''
HaplotypeCaller
'''
rule haplotypeCaller:
	input:
		bam="{sample}_recal.bam",
		dbsnp={dbsnp}
		#vcfdir="../vcf_files"
	output:
		gvcf="gvcf_files/{sample}_raw_variants.g.vcf",
		#gvcfs_list="../{fam_name}_gvcf_files.list"
	threads: 24
	shell:
		"GenomeAnalysisTK -Xmx32g \ "
		"-T HaplotypeCaller \ "
		"-R {ref} \ "
		"-I {input.bam} \ "
		"--dbsnp {input.dbsnp} \ "
		"--genotyping_mode DISCOVERY \ "
		"-stand_emit_conf 10 \ "
		"-stand_call_conf 30 \ "
		"--emitRefConfidence GVCF \ "
		"--variant_index_type LINEAR \ "
		"--variant_index_parameter 128000 \ "
		"-nct {threads} \ "
		"-o {output.gvcf} \ "
		# "| bgzip -c > {output}"
		# "&& tabix -p vcf {output}"
		#"&& echo $(basename {output.gvcf}) >> ../gvcf_files.list"
		
		# Write to logfile
		"&& echo 'HaplotypeCaller' >> {log_file}"


'''
GenotypeGVCFs
'''
# gvcfs=glob.glob("*.g.vcf")
# print(gvcfs)
rule genotypeGVCFs:
	input:
		#gvcfs_list="../{fam_name}_gvcf_files.list",
		#gvcfs=glob.glob("*.g.vcf"),
		gvcfs=expand("gvcf_files/{sample}_raw_variants.g.vcf", sample=SAMPLES),
		dbsnp={dbsnp}
	output:
		"{fam_name}_variants.vcf"
	params:
		gvcfs=expand("-V gvcf_files/{sample}_raw_variants.g.vcf", sample=SAMPLES),
	shell:
		"GenomeAnalysisTK -Xmx32g \ "
		"-T GenotypeGVCFs \ "
		"-R {ref} \ "
		#"-V G37-01215-06_nimblegen-exome-utr_C1NEGACXX_raw_variants.g.vcf \ "
		#"-V G37-A028_nimblegen-exome-utr_C1NEGACXX_raw_variants.g.vcf \ "
		#"-V G37-A043_nimblegen-exome-utr_C1NEGACXX_raw_variants.g.vcf \ "
		#"-V {input.gvcfs_list} \ "
		"{params.gvcfs} \ "
		"--dbsnp {input.dbsnp} \ "
		"-stand_emit_conf 10 \ "
		"-stand_call_conf 30 \ "
		"-o {output}"


'''

Maybe useful rules:

rule sort_bam:
	input:
		"{sample}_reDup.bam"
	output:
		"{sample}_reDup_sorted.bam"
	shell:
		"picard SortSam SO=coordinate I={input} O={output}"

rule add_read_groups:
	input:
		"{sample}_reDup_sorted.bam"
	output:
		"{sample}_reDup_sorted_addedGroups.bam"
	shell:
		"picard -Xmx4g AddOrReplaceReadGroups I={input} O={output} RGID=4 RGLB=lib1 RGPL=illumina RGPU=unit1 RGSM=20"
		
		
rule realignerTargetCreator:
	input:
		ref={ref},
		bam="{sample}_reDup_addedGroup.bam",
		bai="{sample}_reDup_addedGroup.bam.bai"
	output:
		"{sample}_output.intervals"
	shell:
		"GenomeAnalysisTK -T RealignerTargetCreator -R {input.ref} -o {output} -I {input.bam}"

-----
Test af recalibration
		
rule patterns_covariation_pass2:
	input:
		bam="{sample}_reDup_addedGroup.bam",
		gold_indels="Mills_and_1000G_gold_standard.indels.b37.vcf",
		dbsnp="dbsnp_138.b37.vcf",
		table="{sample}_recal_data.table"
	output:
		"{sample}_post_recal_data.table"
	shell:
		"GenomeAnalysisTK -T BaseRecalibrator -R {ref} -I {input.bam} -L 20 -knownSites {input.dbsnp} -knownSites {input.gold_indels} -BQSR {input.table} -o {output}"

rule generate_recalibration_plots:
	input:
		before="{sample}_recal_data.table",
		after="{sample}_post_recal_data.table"
	output:
		"{sample}_recalibration_plots.pdf"
	shell:
		"GenomeAnalysisTK -T AnalyzeCovariates -R {ref} -L 20 -before {input.before} -after {input.after} -plots {output}"
-----

### Consider combining into one pre-process step...
'''
# Downloads list of known SNPs if not already in the directory
'''
# rule get_dbsnp_vcf_file:
# 	params:
# 		link="ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/2.8/b37/"
# 	output:
# 		"dbsnp_138.b37.vcf"
# 	shell:
# 		"wget {params}{output}.gz | gunzip {output}.gz"


'''
# Downloads list of golden standard indels if not already in the directory
'''
# rule get_gold_indels_vcf_file:
# 	params:
# 		link="ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/2.8/b37/"
# 	output:
# 		"Mills_and_1000G_gold_standard.indels.b37.vcf"
# 	shell:
# 		"wget {params}{output}.gz | gunzip {output}.gz"


'''

		
'''
Random test function for time testing
'''
rule test:
	output:
		"nothing.txt"
	shell:
		"sleep 3600"
		"&& echo 'I did nothing but sleep for 5 sec' > nothing.txt"
		# "&& return 1" # To simulate error
