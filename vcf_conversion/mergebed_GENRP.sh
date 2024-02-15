#!/usr/bin/env bash
#SBATCH --time=05:00:00
#SBATCH --job-name=mergebed_GENRP
#SBATCH --mem=50GB
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --error=TestJob.%J.stderr
#SBATCH --error=TestJob.%J.stdout

# Merge plink .bed files per chromosome into a single .bed file
cd /home/n.creasey/GENRP_bedfiles

for i in {1..22}
do
echo chr$i >> mergelist.txt
done

plink19 --merge-list mergelist.txt --make-bed --out allchr_GENRP