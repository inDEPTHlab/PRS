### Preparation of Alzheimer PRS for PRSice
### Author: Alexander Neumann (a.neumann@erasmusmc.nl)

library(data.table)

# Read in summary stats
alzheimer <- fread("original/AD_sumstats_Jansenetal.txt.gz")

# Fix variable names
alz_names <- names(alzheimer)
alz_names[c(1,2)] <- alz_names[c(2,3)]
alz_names[c(3,4)] <- c("BP", "A1")
names(alzheimer) <- alz_names

# Exclude APOE locus
alzheimer[!(alzheimer$CHR == 19 & alzheimer$BP >= 45020859 & alzheimer$BP <= 45844508), ]

# Extract chromosome:position ID
alzheimer$cptid <-  paste(alzheimer$CHR, alzheimer$BP, sep = ":")
# Select only necessary columns
alzheimer <- alzheimer[,.(cptid,A1,BETA,P)]
# Rename columns
names(alzheimer) <- c("cptid","ea","beta","pvalue")

# Write base file for PRSice
fwrite(alzheimer, file = "prs_base/alzheimer.txt", sep  = " ", quote = F, row.names = F, na = "NA")
system("gzip prs_base/alzheimer.txt")