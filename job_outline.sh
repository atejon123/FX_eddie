#!/bin/sh
#$ -N FX_Job         # Job name
#$ -cwd             # Use current directory
#$ -l h_rt=08:00:00 # Time limit (hh:mm:ss)
#$ -l h_vmem=19G     # Memory required
#$ -pe sharedmem 1

# Load R module
module load R

# Run R script
Rscript analysis.R
