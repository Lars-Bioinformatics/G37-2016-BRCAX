#!/bin/bash
SAMP_NAME=G37-B14
WORK=/work/sduvarcall/G37-2016-BRCAX-Genomes
REF_BASE=/work/sduvarcall/G37-2016-BRCAX-Genomes/resources/core_ref_GRCh37d5
CPU_TO_USE=1

mkdir -p $WORK/bam_out/$SAMP_NAME
rm -rf $WORK/bam_out/${SAMP_NAME}/*


python2 ~/udocker run  \
--workdir=/ \
--user=laran  \
--volume=$WORK:/work  \
--volume=${REF_BASE}:/var/spool/ref  \
--volume=$WORK/180303_POOL3_POOL4_S2FLOWCELL/fastq:/var/spool/S2FLOWCELL  \
--volume=$WORK/180323_A00316_0014_AH2HCKDSXX/fastq:/var/spool/AH2HCKDSXX  \
--volume=$WORK/180409_A00316_0016_AH2H7HDSXX/fastq:/var/spool/AH2H7HDSXX  \
cgpmap3  \
ds-cgpmap.pl  \
-outdir bam_out/G37-B14  \
-reference /var/spool/ref/  \
-bwa_idx /var/spool/ref/	 \
-sample G37-B14  \
-threads 1  \
-groupinfo /work/ReadGroupsYAML/ReadGroups_G37-B14.yaml  \
/var/spool/AH2HCKDSXX/G37-B14_*_[12].fastq.gz  \
/var/spool/AH2H7HDSXX/G37-B14_*_[12].fastq.gz  \
/var/spool/S2FLOWCELL/G37-B14_*_[12].fastq.gz


#--volume=$WORK/180409_A00316_0017_BH2H7JDSXX/fastq:/var/spool/BH2H7JDSXX  \
