# SAMPLES, = glob_wildcards("bam/{sample}.bam")
configfile: "/work/sduvarcall/G37-2016-BRCAX-Genomes/samples.yaml"
SAMPLES = [config[s]["normal"] for s in config] + [config[s]["tumor"] for s in config]
print(SAMPLES)


ref = "/work/sdukoldby/resources/hg38/Homo_sapiens_assembly38.fasta"

# NGSCheckMate install dir
ncm_dir = "/work/sduvarcall/G65-2017-Kidstage/NGSCheckMate"

onstart:
    shell("mkdir -p NGSCheckMate_output")

rule all:
    input:
        "NGSCheckMate_output/bam_matching/output_all.txt",
        # "NGSCheckMate_output/fastq_matching/output_all.txt"


###############################################################################
### NGSCheckMate on FastQ files
###############################################################################
rule ngscheckmate_fastq:
    input:
        f1="fastq/{sample}_R1.fastq.gz",
        f2="fastq/{sample}_R2.fastq.gz",
        pt="NGSCheckMate/SNP/SNP.pt"
    output:
        vaf="NGSCheckMate_output/vaf/{sample}.vaf"
    shell:
        """
        ./NGSCheckMate/ngscheckmate_fastq -1 {input.f1} -2 {input.f2} {input.pt} > {output.vaf}
        """

rule vaf_ncm:
    input:
        vaf=expand("NGSCheckMate_output/vaf/{sample}.vaf", sample=SAMPLES)
    output:
        "NGSCheckMate_output/fastq_matching/output_all.txt"
    params:
        in_dir=directory("NGSCheckMate_output/vaf/"),
        out_dir=directory("NGSCheckMate_output/fastq_matching"),
        prefix="output"
    shell:
        """
        python2 {ncm_dir}/vaf_ncm.py -f -I {params.in_dir} -O {params.out_dir} {params.prefix}
        """


###############################################################################
### NGSCheckMate on bam files
###############################################################################
rule vcf_from_bam:
    input:
        # bam="bam_out/{sample}/{sample}.bam",
        bam="bam_recalibrated/{sample}_recal.bam",
        bed=ncm_dir+"/SNP/SNP_GRCh38_hg38_wChr.bed",
    output:
        vcf="NGSCheckMate_output/vcf/{sample}.vcf"
    shell:
        """
        samtools mpileup -I -uf {ref} -l {input.bed} {input.bam} | bcftools call -c - > {output.vcf}
        """

rule create_vcf_sampleList:
    input:
        vcf=expand("NGSCheckMate_output/vcf/{sample}.vcf", sample=SAMPLES),
    output:
        sampleList="NGSCheckMate_output/vcf/NGSCheckMate_vcf_sampleList.txt"
    shell:
        """
        (cd NGSCheckMate_output/vcf && ls -1 *.vcf > `basename {output}`)
        """

rule ngscheckmate_bam:
    input:
        vcf=expand("NGSCheckMate_output/vcf/{sample}.vcf", sample=SAMPLES),
        bed=ncm_dir+"/SNP/SNP_GRCh38_hg38_wChr.bed",
        sampleList="NGSCheckMate_output/vcf/NGSCheckMate_vcf_sampleList.txt"
    output:
        "NGSCheckMate_output/bam_matching/output_all.txt"
    params:
        in_dir=directory("NGSCheckMate_output/vcf"),
        out_dir=directory("NGSCheckMate_output/bam_matching")
    shell:
        """
        python2 {ncm_dir}/ncm.py -V -d {params.in_dir} -bed {input.bed} -O {params.out_dir}
        """
