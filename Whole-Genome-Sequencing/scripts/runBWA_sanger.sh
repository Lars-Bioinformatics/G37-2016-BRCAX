#!/bin/bash
SAMP_NAME=G37-B37
WORK=/lustre/scratch119/casm/team228sz/la12
REF_BASE=/lustre/scratch119/casm/team78pipelines/reference/human/GRCh37d5
CPU_TO_USE=6
GROUPINFO=$WORK/ReadGroupsYAML/ReadGroups_${SAMP_NAME}.yaml

mkdir -p $WORK/bam_out/$SAMP_NAME

/software/CGP/canpipe/live/bin/canpipe_live bwa_mem.pl \
	-reference $REF_BASE/genome.fa \
	-outdir $WORK/bam_out/${SAMP_NAME} \
	-sample $SAMP_NAME \
	-threads $CPU_TO_USE \
	-groupinfo $GROUPINFO \
	$WORK/180323_A00316_0014_AH2HCKDSXX/fastq/${SAMP_NAME}*_[12].fastq.gz \
	$WORK/180409_A00316_0017_BH2H7JDSXX/fastq/${SAMP_NAME}*_[12].fastq.gz \
	