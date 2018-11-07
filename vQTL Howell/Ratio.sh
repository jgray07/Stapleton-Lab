#!/bin/bash 

#SBATCH -J HowellRatiovQTL 

#SBATCH -o HowellRatiovQTL%j.txt

#SBATCH -N 1

#SBATCH -n 68

#SBATCH -p normal

#SBATCH -t 10:00:00 

#SBATCH -A iPlant-Collabs

#SBATCH --mail-user=trb9259@uncw.edu

#SBATCH --mail-type=end 



cd $HOME
cd Howell # Change to home directory first, just to make sure SLURM reads from the proper directory

module load Rstats # Load the R module along with some popular packages so it will run R files

Rscript Ratio.R # You may need to change this depending on what exactly With.R is, but if it's a standard R script that can be run from command line, this would suffice

### 4.4min for core=276, n.boot=100
