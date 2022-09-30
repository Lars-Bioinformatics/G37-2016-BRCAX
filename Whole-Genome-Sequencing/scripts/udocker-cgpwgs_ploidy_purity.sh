#!/bin/bash
NORMAL=$1 #G37-B37
TUMOUR=$(echo $NORMAL | tr 'B' 'T') #G37-T37
WORK=/work/sduvarcall/G37-2016-BRCAX-Genomes
#REF_BASE=/lustre/scratch119/casm/team78pipelines/reference/human/GRCh37d5
#CORES=$2

ploidy=$2
purity=$3

# mkdir -p logs_cgpwgs
# mkdir -p wgs_out
mkdir -p $WORK/wgs_out/${NORMAL}_vs_${TUMOUR}_ploidy_purity

CGPWGS_VER=2.0.0

python2 ~/udocker run  \
--workdir=/  \
--user=laran  \
--volume=$WORK:/work  \
cgpwgs \
ds-cgpwgs.pl  \
-outdir /work/wgs_out/${NORMAL}_vs_${TUMOUR}_ploidy_purity  \
-reference /work/resources/core_ref_GRCh37d5.tar.gz  \
-annot /work/resources/VAGrENT_ref_GRCh37d5_ensembl_75.tar.gz  \
-cnv_sv /work/resources/CNV_SV_ref_GRCh37d5_brass6+.tar.gz  \
-snv_indel /work/resources/SNV_INDEL_ref_GRCh37d5-fragment.tar.gz  \
-subcl /work/resources/SUBCL_ref_GRCh37d5.tar.gz  \
-qcset /work/resources/qcGenotype_GRCh37d5.tar.gz  \
-species "Human"  \
-assembly "GRCh37d5"  \
-exclude "NC_007605,hs37d5,GL%"  \
-cores 24  \
-purity $purity  \
-ploidy $ploidy  \
-normal /work/bam_out/$NORMAL/$NORMAL.bam  \
-nidx /work/bam_out/$NORMAL/$NORMAL.bam.bai  \
-tumour /work/bam_out/$TUMOUR/$TUMOUR.bam  \
-tidx /work/bam_out/$TUMOUR/$TUMOUR.bam.bai


#--bind ${REF_BASE}:/var/spool/ref:ro  \
#-reference /var/spool/ref  \
# -purity 0.99  \
# -ploidy 2  \

# Testing settings:
# B3: no cores setting
# B7: 2 cores
# B9: 12 cores
# B22: 24 cores
