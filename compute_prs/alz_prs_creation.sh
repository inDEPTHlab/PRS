### PRS creation script for Alzheimer PRS (Jansen, 2019)
### APOE locus excluded
### Outcome is general psychopathology, but this is just for practical purposes
### Author: Alexander Neumann (a.neumann@erasmusmc.nl)

### Alzheimer
Rscript prsice/PRSice.R --dir . \
--prsice prsice/PRSice_linux \
--base  prs_base/alzheimer.txt.gz \
--beta T \
--snp cptid \
--A1  ea \
--stat beta \
--pvalue pvalue \
--target hrc_bestguess/chr# \
--binary-target F \
--pheno-file gpf.pheno \
--ignore-fid \
--thread 12 \
--all-score \
--out prs/alzheimer \
--bar-levels 0.5,0.4,0.3,0.2,0.1,0.05,0.01,0.001,0.0001,0.000035,0.00001,0.000001,0.0000001,0.00000005,0.00000001 \
--fastscore \
--print-snp
