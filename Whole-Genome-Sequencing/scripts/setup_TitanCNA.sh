conda create -n TitanCNA
conda activate TitanCNA

conda install -c bioconda hmmcopy snakemake bcftools samtools
conda install r=3.6

pip install pysam

# Install R packages
R
## install from CRAN
install.packages("plyr")
install.packages("doMC")
install.packages("optparse")

## install packages from BioConductor
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
# BiocManager::install("HMMcopy")
# BiocManager::install("GenomeInfoDb")
# BiocManager::install("GenomicRanges")
BiocManager::install("SNPchip")
BiocManager::install("AnnotationDbi")
BiocManager::install("Rsamtools")
BiocManager::install("TitanCNA")
BiocManager::install("BSgenome.Hsapiens.UCSC.hg19")

# Install packages from github
install.packages("devtools")
library(devtools)
install_github("broadinstitute/ichorCNA")

