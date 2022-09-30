#!/bin/bash
NORMAL=G37-01226-06
TUMOUR=G37-A085
WORK=/work/sduvarcall/G37-2016-BRCAX-Genomes
#REF_BASE=/lustre/scratch119/casm/team78pipelines/reference/human/GRCh37d5
#CORES=$2

# mkdir -p logs_cgpwgs
# mkdir -p wgs_out
mkdir -p $WORK/exome_test/${NORMAL}_vs_${TUMOUR}

python2 ~/udocker run  \
--workdir=/  \
--user=laran  \
--volume=$WORK:/work  \
cgpwxs \
ds-cgpwxs.pl  \
-outdir /work/exome_test/${NORMAL}_vs_${TUMOUR}  \
-reference /work/resources/core_ref_GRCh37d5.tar.gz  \
-annot /work/resources/VAGrENT_ref_GRCh37d5_ensembl_75.tar.gz  \
-snv_indel /work/resources/SNV_INDEL_ref_GRCh37d5-fragment.tar.gz  \
-species "Human"  \
-assembly "GRCh37d5"  \
-exclude "NC_007605,hs37d5,GL%"  \
-cores 24  \
-normal /work/exome_test/${NORMAL}_nimblegen-exome-utr_C2FAGACXX_recal.bam  \
-nidx /work/exome_test/${NORMAL}_nimblegen-exome-utr_C2FAGACXX_recal.bai  \
-tumour /work/exome_test/${TUMOUR}_nimblegen-exome-utr_C2FAGACXX_recal.bam  \
-tidx /work/exome_test/${TUMOUR}_nimblegen-exome-utr_C2FAGACXX_recal.bai
