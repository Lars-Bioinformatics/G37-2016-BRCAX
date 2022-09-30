WORK="/work/sduvarcall/G37-2016-BRCAX-Genomes/"
INPUT_BAM = WORK+"bam_out/"
OUTPUT = WORK+"cnvkit/"

configfile: WORK+"samples.yaml"

ref_build = "GRCh37"

# Resources - paths inside docker
if ref_build == "GRCh37":
    # GRCh37 paths
    ref = "/work/sduvarcall/G37-2016-BRCAX-Genomes/reference_files/core_ref_GRCh37d5/genome.fa"
    access = "/work/sduvarcall/Resources/GRCh37/cnvkit/access-5k-mappable.grch37.bed"
    annotation_db = "/work/sduvarcall/Resources/GRCh37/cnvkit/refFlat.txt"
else:
    # GRCh38 paths
    ref = "/work/sduvarcall/G37-2016-BRCAX-Genomes/reference_files_GRCh38/core_ref_GRCh38_hla_decoy_ebv/genome.fa"


# segment_method = "haar"
segment_method = "cbs"

OUTPUT = OUTPUT+segment_method+"_segmentation/"

# Get sample names from config file
# SAMPLES, = glob_wildcards(INPUT_BAM+"{sample}.bam")
# SAMPLES = ["G56-sampleA1_nimblegen-medexome_HGL2LDSXX"]
# print(SAMPLES)
TUMORS = [config[s]["tumor"] for s in config]
NORMALS = [config[s]["normal"] for s in config]
print(TUMORS)

onstart:
    shell("mkdir -p "+OUTPUT)

rule all:
    input:
        OUTPUT+"flat_reference.cnn",
        # expand(OUTPUT+"{tumor}_vs_{normal}.cnr", tumor=TUMORS, normal=NORMALS)


rule cnvkit:
    input:
        tumors=expand(INPUT_BAM+"{tumor}/{tumor}.bam", tumor=TUMORS),
        normals=expand(INPUT_BAM+"{normal}/{normal}.bam", normal=NORMALS),
        # tumors=INPUT_BAM+"{tumor}/{tumor}.bam",
        # normals=INPUT_BAM+"{normal}/{normal}.bam",
    output:
        flat_ref=OUTPUT+"flat_reference.cnn",
        cnn=expand(OUTPUT+"{tumor}.cnr", tumor=TUMORS)
    threads: 64
    shell:
        """
        cnvkit.py batch \
            {input.tumors} \
            --normal {input.normals}\
            --fasta {ref} \
            --access {access} \
            --annotate {annotation_db} \
            --output-reference {output.flat_ref} \
            --output-dir {OUTPUT} \
            -p {threads} \
            --segment-method {segment_method} \
            --method wgs \
            --scatter --diagram
        """

# rule cnvkit_scatter:
#     input:
#         cnr=INPUT_BAM+"{sample}.cnr"
#     output:
#         cns=INPUT_BAM+"{sample}.cns"
#     shell:
#         """

#         """