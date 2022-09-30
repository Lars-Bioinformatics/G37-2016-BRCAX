#!/bin/bash
NORMAL=$1 #G37-B37
TUMOUR=$(echo $NORMAL | tr 'B' 'T') #G37-T37
WORK=/lustre/scratch119/casm/team228sz/la12
#REF_BASE=/lustre/scratch119/casm/team78pipelines/reference/human/GRCh37d5
CORES=$2

# mkdir -p logs_cgpwgs
# mkdir -p wgs_out
mkdir -p $WORK/wgs_out/${NORMAL}_vs_${TUMOUR}

CGPWGS_VER=2.0.0

singularity exec  \
--workdir $WORK  \
--home $WORK:/home  \
dockstore-cgpwgs-${CGPWGS_VER}.simg  \
ds-cgpwgs.pl  \
-outdir wgs_out/${NORMAL}_vs_${TUMOUR}  \
-reference resources/core_ref_GRCh37d5.tar.gz  \
-annot resources/VAGrENT_ref_GRCh37d5_ensembl_75.tar.gz  \
-cnv_sv resources/CNV_SV_ref_GRCh37d5_brass6+.tar.gz  \
-snv_indel resources/SNV_INDEL_ref_GRCh37d5-fragment.tar.gz  \
-subcl resources/SUBCL_ref_GRCh37d5.tar.gz  \
-qcset resources/qcGenotype_GRCh37d5.tar.gz  \
-species "human"  \
-assembly "GRCh37d5"  \
-exclude ""  \
-cores $CORES  \
-cavereads 800000  \
-normal bam_out/$NORMAL/$NORMAL.bam  \
-nidx bam_out/$NORMAL/$NORMAL.bam.bai  \
-tumour bam_out/$TUMOUR/$TUMOUR.bam  \
-tidx bam_out/$TUMOUR/$TUMOUR.bam.bai


#--bind ${REF_BASE}:/var/spool/ref:ro  \
#-reference /var/spool/ref  \
# -purity 0.99  \
# -ploidy 2  \
