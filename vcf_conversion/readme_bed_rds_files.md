# Conversion of GenR 1000G imputed .vcf files to plink .bed files
This folder contains plink .bed and R .rds, which contain 1000G imputed
genotypes (hard call) for GenR children or parents. The files have undergone
additional QC and are meant to be used for further downstream analyses with 
software, which assumes plink .bed or R bignspr .rds files, such as PRSice2 or
ldpred-2 for polygenic score computations. Note, that the conversion procedure 
(see below for details) only keeps common autosomal bi-allelic SNPs with good
imputation quality and loses information on imputation uncertainty. This is 
appropriate for many methods, which aggregate SNP effects (PGS, GCTA-GREML, etc),
but for GWAS original .vcf files should be used.

## Source files
The source files for creation of the .bed files are:

```
/data/GENR3/Imputed/1000G_PhaseIIIv5/chr$chnum.dose.vcf.gz
/data/GENR4/Imputed/1000G_PhaseIIIv5/GenR_Kids/GenRKids_IDC_Chr$chnum.dose.vcf.gz
/data/GENR4/Imputed/1000G_PhaseIIIv5/GenR_Moms/GenRMoms_IDC_Chr$chnum.dose.vcf.gz
/data/GENR-Parents/Imputed/1000G_PhaseIIIv5/GENR_parents_Chr$chnum.dose.vcf.gz
```

## Conversion scripts
```
cf2plink_GENR*.sh
mergebed_GENR*sh
```

## QC steps
1. Keep only autosomal chromosomes
2. Remove multi-allelic SNPs
3. Remove duplicate variants
4. Remove structural variants (InDels)
5. Keep only SNPs with imputation quality R^2 >= 80%
6. Keep only SNPs with minor allele frequency >= 1%

## Decriptives
This QC procedures results in following number of pariticpants and SNPs

* GenR3 Children: XXX participants, XXX snps
* GenR4 Children: XXX participants, XXX snps
* GenR4 Mothers: XXX participants, XXX snps
* GenR Parents: XXX participants, XXX snps

## Additional conversions
.bed files are given either per chromosome, or as merged files across all
autosomes. Furthermore, .rds files are provided, which are bignspr conversions
of the merged .bed files. The command used for the conversion was:

```
bigsnpr::snp_readBed
```

## Further information
Code can also be found on the inDEPTHlab github:
https://github.com/inDEPTHlab/PRS

## Authors
Authors: Nicole Creasey, Isabel Schuurmans, Alexander Neumann

Maintainer: Alexander Neumann (a.neumann@erasmusmc.nl;
alexander.neumann.science@gmail.com)
