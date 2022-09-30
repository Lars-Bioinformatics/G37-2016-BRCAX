import glob, os, textwrap

# input dirs containing fastq files
inputDirs = ["180323_A00316_0014_AH2HCKDSXX/fastq", 
			 "180409_A00316_0016_AH2H7HDSXX/fastq", 
			 "180409_A00316_0017_BH2H7JDSXX/fastq",	 
			 "180303_POOL3_POOL4_S2FLOWCELL/fastq"]

outScriptsDir = "scripts/udocker_cgpmap_sample_scripts/"

os.system("mkdir -p "+outScriptsDir)
os.system("rm -rf "+outScriptsDir+"*")

CPU_TO_USE = 12

def writeScript(out,sampleid):
	out.write(textwrap.dedent(
		"""
		#!/bin/bash
		SAMP_NAME=%s
		WORK=/work/sduvarcall/G37-2016-BRCAX-Genomes/
		REF_BASE=/work/sduvarcall/G37-2016-BRCAX-Genomes/resources/core_ref_GRCh37d5
		CPU_TO_USE=%i

		mkdir -p $WORK/bam_out/$SAMP_NAME
		rm -rf $WORK/bam_out/${SAMP_NAME}/*


		python2 ~/udocker run  \\
		--volume=$WORK:/work  \\
		--volume=${REF_BASE}:/var/spool/ref  \\
		--volume=$WORK/180303_POOL3_POOL4_S2FLOWCELL/fastq:/var/spool/S2FLOWCELL  \\
		--volume=$WORK/180323_A00316_0014_AH2HCKDSXX/fastq:/var/spool/AH2HCKDSXX  \\
		--volume=$WORK/180409_A00316_0016_AH2H7HDSXX/fastq:/var/spool/AH2H7HDSXX  \\
		--volume=$WORK/180409_A00316_0017_BH2H7JDSXX/fastq:/var/spool/BH2H7JDSXX  \\
		cgpmap  \\
		ds-cgpmap.pl  \\
		-outdir /work/bam_out/${SAMP_NAME}  \\
		-reference /var/spool/ref  \\
		-bwa_idx /var/spool/ref	 \\
		-sample $SAMP_NAME  \\
		-threads $CPU_TO_USE  \\
		-groupinfo /work/ReadGroupsYAML/ReadGroups_${SAMP_NAME}.yaml
		""" % (sampleid, CPU_TO_USE)).strip()
	)

def appendSampleDir(out, dir_name):
	out.write(
		"  \\\n/var/spool/"+dir_name+"/${SAMP_NAME}_*_[12].fastq.gz"
	)

for directory in inputDirs:
	#print directory
	for filename in glob.iglob(directory+"/*_1.fastq.gz"):
		
		# Assume filename follows the following pattern:
		# SAMPLEID_PROTOCOL_FLOWCELLID_READ.fastq.gz
		basename = filename.split("/")[-1]
		sampleid, protocol, flowcell, read = basename.split("_")
		
		#print sampleid, protocol, flowcell, read
		
		dir_name = directory.split("/")[0].split("_")[3]
		# print dir_name
		
		# Get output yaml file name
		script_file = outScriptsDir+"udocker_cgpmap_"+sampleid+".sh"
		#print script_file
		
		# Write script file
		with open(script_file, "a") as out:
			# if file empty, create header
			if os.path.getsize(script_file) == 0:
				writeScript(out, sampleid)

			# Write read group information for sample
			appendSampleDir(out, dir_name)
			

# for filename in glob.iglob(outScriptsDir+"*.sh"):
# 	sampleid = filename.split("_")[-1].split(".")[0]
# 	# print sampleid
# 	# Set correct permissions for script execution
# 	#os.system("chmod 755 "+filename)
# 	#cmd = "bsub -o logs/output_"+sampleid+".%J -e logs/errorfile_"+sampleid+".%J -n "+str(CPU_TO_USE)+" -R 'span[hosts=1]' -R 'select[mem>8000]' -q singularity "+filename
# 	cmd = "NEEDS UPDATED FOR SLURM"
# 	print cmd
	# Run script 
	#os.system(cmd)
	
	## RUN SUBSET OF SCRIPTS
	# sampleid = filename.split("_")[-1].split(".")[0]
	# if sampleid not in ("G37-B35","G37-B36","G37-B37"):
	# 	# Run script
	# 	os.system(cmd)