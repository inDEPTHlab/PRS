# Conversion of a HRC imputed file into a plink .bed/.bim/.fam file with some QC
# Note, that you will loose imputation uncretainty (hard call), but necessary
# for many downstream PRS software such as PRSice or PRS-CS

# Loop through all autosomes 
# (most GWAS exclude X-chromosome, so it is removed here)
for chnum in {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22};
  do
  # Read vcf file and convert
  plink --vcf /data/GENR3/Imputed/HRC_release1.1/chr$chnum.dose.vcf.gz \
  --make-bed --out chr$chnum
  # Merge with itself to identify multi-allelic SNPs
  plink --bfile chr$chnum --bmerge chr$chnum --merge-mode 6
  # Exclude multi-allelic SNPs
  plink --bfile chr$chnum --exclude plink.missnp --make-bed --out chr$chnum
  # Clean up duplicate file
  rm *~
  # Identify duplicate variants
  plink --bfile chr$chnum --list-duplicate-vars
  # Remove duplicate variants
  plink --bfile chr$chnum --exclude plink.dupvar --make-bed --out chr$chnum
  # CLean up duplicate file
  rm *~
  # Collect additional SNP info
  zcat /data/GENR3/Imputed/HRC_release1.1/chr$chnum.info.gz > chr$chnum.info
  # Filter by imputation quality and minor allele frequency
  # Imputation quality is obtained by referencing the 7th column in .info
  # 7 1 1 indicated the qual column, 1 the SNP ID, 1 line to skip
  # Note: RS of 80% quite conservative for GWAS but common for PRS
  # PRS are aggregate scores, so cannot post-hoc discuss individual SNPs
  # Ergo: better ensure you only enter good quality SNPs
  plink --bfile chr$chnum \
  --qual-scores chr$chnum.info 7 1 1 --qual-threshold 0.8 --maf 0.01 \
  --make-bed --out chr$chnum
  # Remove the info and duplicate files
  rm chr$chnum.info
  rm *~
done
