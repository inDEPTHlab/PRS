#!/usr/bin/env bash
#SBATCH --time=05:00:00
#SBATCH --job-name=cf2plink_GENRP
#SBATCH --mem=50GB
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --error=TestJob.%J.stderr
#SBATCH --error=TestJob.%J.stdout

# Conversion of a 1000G .vcf imputed file into a plink .bed/.bim/.fam file with some QC
# Note, that you will loose imputation uncretainty (hard call), but necessary
# for many downstream PRS software such as PRSice, LDpred-2 or PRS-CS

# Change directory to target folder
cd /home/n.creasey/GENRP_bedfiles

# Loop through all autosomes 
# (most GWAS exclude X-chromosome, so it is removed here)
for chnum in {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22};
  do
  # Read vcf file and convert
  plink2 --vcf /home/n.creasey/GENR-Parents/Imputed/1000G_PhaseIIIv5/GENR_parents_Chr$chnum.dose.vcf.gz --make-bed --out chr$chnum --set-all-var-ids @:#
  # Merge with itself to identify multi-allelic SNPs
  plink19 --bfile chr$chnum --bmerge chr$chnum --merge-mode 6
  # Exclude multi-allelic SNPs
  plink19 --bfile chr$chnum --exclude plink.missnp --make-bed --out chr$chnum
  # Clean up multi-allelic SNP file
  rm *~
  # Identify duplicate variants
  plink19 --bfile chr$chnum --list-duplicate-vars
  # Remove duplicate variants
  plink19 --bfile chr$chnum --exclude plink.dupvar --make-bed --out chr$chnum
  # Clean up duplicate file
  rm *~
  # Remove structural variants (InDels)
  awk '{ if (length($5) > 1 || length($6) > 1) print $2 }' chr$chnum.bim > indels_to_remove.txt
  plink19 --bfile chr$chnum --exclude indels_to_remove.txt --make-bed --out chr$chnum
  # Clean up strucutral variants files
  rm *~
  rm indels_to_remove.txt
  # Collect additional SNP info
  zcat /home/n.creasey/GENR4/Imputed/1000G_PhaseIIIv5/GENR_parents_Chr$chnum.info.gz > chr$chnum.info
  # Filter by imputation quality (R2>=80%) and minor allele frequency (MAF>=1%)
  # Imputation quality is obtained by referencing the 7th column in .info
  # 7 1 1 indicate the qual column, SNP ID, 1 line to skip
  # Note: RS of 80% quite conservative for GWAS but common for PRS
  # PRS are aggregate scores, so cannot post-hoc discuss individual SNPs
  # Ergo: better ensure you only enter good quality SNPs
  plink19 --bfile chr$chnum \
  --qual-scores chr$chnum.info 7 1 1 --qual-threshold 0.8 --maf 0.01 \
  --make-bed --out chr$chnum
  # Remove the info and duplicate files
  rm chr$chnum.info
  rm *~
done


