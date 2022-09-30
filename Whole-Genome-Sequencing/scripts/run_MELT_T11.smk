WORK = "/work/sduvarcall/G37-2016-BRCAX-Genomes/"
OUTPUT = WORK+"MELT_output"
ref = WORK+"reference_files/core_ref_GRCh37d5/genome.fa"
melt_jar = WORK+"MELTv2.2.2/MELT.jar"
melt_bed = WORK+"MELTv2.2.2/add_bed_files/1KGP_Hg19/hg19.genes.bed"
mei_list = WORK+"MELTv2.2.2/mei.txt"


rule all:
    input:
        expand(OUTPUT+"{sample}/SVA.final_comp.vcf", 
               sample=["G37-B10","G37-T10","G37-B37","G37-T37"])

rule melt:
    input:
        bam=WORK+"bam_out/{sample}/{sample}.bam"
    output:
        vcf=OUTPUT+"{sample}/SVA.final_comp.vcf"
    shell:
        """
        java -Xmx6G -jar {melt_jar} Single \
        -a \
        -b hs37d5/NC_007605 \
        -bamfile {input.bam} \
        -h {ref} \
        -w {OUTPUT}/{wildcards.sample} \
        -t {mei_list} \
        -n {melt_bed}
        """