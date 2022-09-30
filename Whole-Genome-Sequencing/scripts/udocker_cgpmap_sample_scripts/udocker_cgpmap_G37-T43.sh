#!/bin/bash
SAMP_NAME=G37-T43
WORK=/work/sduvarcall/G37-2016-BRCAX-Genomes/
REF_BASE=/work/sduvarcall/G37-2016-BRCAX-Genomes/resources/core_ref_GRCh37d5
CPU_TO_USE=1

mkdir -p $WORK/bam_out/$SAMP_NAME
rm -rf $WORK/bam_out/${SAMP_NAME}/*


python2 ~/udocker run  \
--volume=$WORK:/work  \
--volume=${REF_BASE}:/var/spool/ref  \
--volume=$WORK/180303_POOL3_POOL4_S2FLOWCELL/fastq:/var/spool/S2FLOWCELL  \
--volume=$WORK/180323_A00316_0014_AH2HCKDSXX/fastq:/var/spool/AH2HCKDSXX  \
--volume=$WORK/180409_A00316_0016_AH2H7HDSXX/fastq:/var/spool/AH2H7HDSXX  \
--volume=$WORK/180409_A00316_0017_BH2H7JDSXX/fastq:/var/spool/BH2H7JDSXX  \
cgpmap  \
ds-cgpmap.pl  \
-outdir /work/bam_out/${SAMP_NAME}  \
-reference /var/spool/ref  \
-bwa_idx /var/spool/ref	 \
-sample $SAMP_NAME  \
-threads $CPU_TO_USE  \
-groupinfo /work/ReadGroupsYAML/ReadGroups_${SAMP_NAME}.yaml  \
/var/spool/AH2HCKDSXX/${SAMP_NAME}_*_[12].fastq.gz  \
/var/spool/BH2H7JDSXX/${SAMP_NAME}_*_[12].fastq.gz