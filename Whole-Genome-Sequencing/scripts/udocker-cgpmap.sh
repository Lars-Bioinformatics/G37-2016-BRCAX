#!/usr/bin/bash
SAMP_NAME=$1 #G37-B37
WORK=/work/sduvarcall/G37-2016-BRCAX-Genomes/
REF_BASE=/work/sduvarcall/G37-2016-BRCAX-Genomes/resources/core_ref_GRCh37d5
#REF_BASE=$WORK/reference
CPU_TO_USE=6
#GROUPINFO=$WORK/ReadGroupsYAML/ReadGroups_${SAMP_NAME}.yaml

#mkdir -p $WORK/bam_out/$SAMP_NAME


#python2 ~/udocker pull quay.io/wtsicgp/dockstore-cgpmap:3.0.4
#python2 ~/udocker -D create --name=cgpmap quay.io/wtsicgp/dockstore-cgpmap:3.0.4
#python2 ~/udocker run cgpmap ds-cgpmap.pl -h

echo $SAMP_NAME

python2 ~/udocker run  \
--workdir=/ \
--user=laran  \
--volume=$WORK:/var/spool  \
--volume=${REF_BASE}:/var/spool/ref  \
--volume=$WORK/180303_POOL3_POOL4_S2FLOWCELL/fastq:/var/spool/S2FLOWCELL  \
--volume=$WORK/180323_A00316_0014_AH2HCKDSXX/fastq:/var/spool/AH2HCKDSXX  \
--volume=$WORK/180409_A00316_0016_AH2H7HDSXX/fastq:/var/spool/AH2H7HDSXX  \
--volume=$WORK/180409_A00316_0017_BH2H7JDSXX/fastq:/var/spool/BH2H7JDSXX  \
cgpmap  \
ds-cgpmap.pl  \
-outdir /var/spool/bam_out/${SAMP_NAME}  \
-sample ${SAMP_NAME}  \
-threads ${CPU_TO_USE}  \
-groupinfo /var/spool/ReadGroupsYAML/ReadGroups_${SAMP_NAME}.yaml  \
-reference /var/spool/resources/core_ref_GRCh37d5.tar.gz  \
-bwa_idx /var/spool/resources/bwa_idx_GRCh37d5.tar.gz  \
/var/spool/S2FLOWCELL/${SAMP_NAME}_illumina-truseq-genome_S2FLOWCELL_1.fastq.gz  \
/var/spool/S2FLOWCELL/${SAMP_NAME}_illumina-truseq-genome_S2FLOWCELL_2.fastq.gz  \
/var/spool/AH2HCKDSXX/${SAMP_NAME}_illumina-truseq-genome_H2HCKDSXX_1.fastq.gz  \
/var/spool/AH2HCKDSXX/${SAMP_NAME}_illumina-truseq-genome_H2HCKDSXX_2.fastq.gz  \
/var/spool/AH2H7HDSXX/${SAMP_NAME}_illumina-truseq-genome_H2H7HDSXX_1.fastq.gz  \
/var/spool/AH2H7HDSXX/${SAMP_NAME}_illumina-truseq-genome_H2H7HDSXX_2.fastq.gz
# /var/spool/BH2H7JDSXX/${SAMP_NAME}_illumina-truseq-genome_H2H7JDSXX_1.fastq.gz \
# /var/spool/BH2H7JDSXX/${SAMP_NAME}_illumina-truseq-genome_H2H7JDSXX_2.fastq.gz

#-reference /var/spool/resources  \
#-r /var/spool/resources/core_ref_GRCh37d5.tar.gz  \
#-i /var/spool/resources/bwa_idx_GRCh37d5.tar.gz  \ 
#-s $SAMP_NAME  \
#-t $CPU_TO_USE  \
#-groupinfo /home/ReadGroupsYAML/ReadGroups_${SAMP_NAME}.yaml  \

#/bin/bash; echo $SHELL \
#cat /opt/wtsi-cgp/bin/ds-cgpmap.pl > ds-cgpmap4.pl
#cat /opt/wtsi
#ls /var/spool/S2FLOWCELL

# TESTING
# --bind $WORK/pool1:/var/spool/pool1:ro  \
# --bind $WORK/pool2:/var/spool/pool2:ro  \
# /var/spool/pool1/${SAMP_NAME}*_[12].fastq.gz  \
# /var/spool/pool2/${SAMP_NAME}*_[12].fastq.gz

#/var/spool/S2FLOWCELL/${SAMP_NAME}*_[12].fastq.gz  \
#/var/spool/AH2H7HDSXX/${SAMP_NAME}*_[12].fastq.gz  \