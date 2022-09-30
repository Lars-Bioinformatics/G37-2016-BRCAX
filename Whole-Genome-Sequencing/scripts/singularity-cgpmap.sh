#!/bin/bash
SAMP_NAME=$1 #G37-B37
WORK=/lustre/scratch119/casm/team228sz/la12
REF_BASE=/lustre/scratch119/casm/team78pipelines/reference/human/GRCh37d5
#REF_BASE=$WORK/reference
CPU_TO_USE=6
#GROUPINFO=$WORK/ReadGroupsYAML/ReadGroups_${SAMP_NAME}.yaml

mkdir -p $WORK/bam_out/$SAMP_NAME

CGPMAP_VER=3.0.4
#singularity pull docker://quay.io/wtsicgp/dockstore-cgpmap:$CGPMAP_VER

singularity exec  \
--workdir $WORK  \
--home $WORK:/home  \
--bind ${REF_BASE}:/var/spool/ref:ro  \
--bind $WORK/180303_POOL3_POOL4_S2FLOWCELL/fastq:/var/spool/S2FLOWCELL:ro  \
--bind $WORK/180323_A00316_0014_AH2HCKDSXX/fastq:/var/spool/AH2HCKDSXX:ro  \
--bind $WORK/180409_A00316_0016_AH2H7HDSXX/fastq:/var/spool/AH2H7HDSXX:ro  \
--bind $WORK/180409_A00316_0017_BH2H7JDSXX/fastq:/var/spool/BH2H7JDSXX:ro  \
dockstore-cgpmap-${CGPMAP_VER}.simg  \
ds-cgpmap.pl  \
-outdir bam_out/${SAMP_NAME}  \
-reference /var/spool/ref  \
-bwa_idx /var/spool/ref  \
-sample $SAMP_NAME  \
-threads $CPU_TO_USE  \
-groupinfo ReadGroupsYAML/ReadGroups_${SAMP_NAME}.yaml  \
/var/spool/S2FLOWCELL/${SAMP_NAME}_*_[12].fastq.gz  \
/var/spool/AH2HCKDSXX/${SAMP_NAME}_*_[12].fastq.gz  \
/var/spool/AH2H7HDSXX/${SAMP_NAME}_*_[12].fastq.gz  \
/var/spool/BH2H7JDSXX/${SAMP_NAME}_*_[12].fastq.gz

#-r /var/spool/ref/core_ref_GRCh37d5.tar.gz  \
#-i /var/spool/ref/bwa_idx_GRCh37d5.tar.gz  \ 
#-s $SAMP_NAME  \
#-t $CPU_TO_USE  \
#-groupinfo /home/ReadGroupsYAML/ReadGroups_${SAMP_NAME}.yaml  \


# TESTING
# --bind $WORK/pool1:/var/spool/pool1:ro  \
# --bind $WORK/pool2:/var/spool/pool2:ro  \
# /var/spool/pool1/${SAMP_NAME}*_[12].fastq.gz  \
# /var/spool/pool2/${SAMP_NAME}*_[12].fastq.gz

#/var/spool/S2FLOWCELL/${SAMP_NAME}*_[12].fastq.gz  \
#/var/spool/AH2H7HDSXX/${SAMP_NAME}*_[12].fastq.gz  \