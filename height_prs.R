### Height summary statistics prep
height <- fread("gwas_summary/GIANT_HEIGHT_YENGO_2022_PGS_WEIGHTS_ALL.gz")
# Create chromosome:position ID
height$cptid <-  paste(height$CHR, height$POS, sep = ":")
# Select only necessary columns
height <- height[,.(cptid,PGS_EFFECT_ALLELE,PGS_WEIGHT)]
# Write base file for plink
fwrite(height, file = "prs_base/height.txt", sep  = " ", quote = F, row.names = F, na = "NA")

### Merge 1000G plink files per chromosome into one file
system("plink --merge-list ~/polygenic_score/hrc_bestguess/chr_merge.txt --make-bed --out ~/polygenic_score/hrc_bestguess/aut")

### PRS scoring
system("plink --bfile ~/polygenic_score/hrc_bestguess/aut --score ~/polygenic_score/prs_base/height.txt --out ~/height/height")

### PRS association analyses
library(data.table)
library(foreign)
library(lme4)

# PRS
height_prs.data <- fread("height.profile")
# General data
general.data <- read.spss("CHILD-ALLGENERALDATA_24102022.sav", to.data.frame = T)
# Ancestry
ancestry.data <- read.spss("PCA_SelectionGWAv3_July2015.sav", to.data.frame = T)

# Merge all data
height_prs_general.data <- merge(height_prs.data, general.data, by.x = "IID", by.y = "IDC")
height.data <- merge(height_prs_general.data, ancestry.data, by.x = "IID", by.y = "idc")

# Z-score standardize height
height.data$height_prs <- scale(height.data$SCORE)

# Regress birth weight on PRS, adjust for gestational age and sex, ancestry PCs (fixed effects)
# Also include European ancestry and family/twin as random intercept, and random slop on ancestry
prs.fit <- lmer(WEIGHT ~ height_prs + GESTBIR + C1 + C2 + C3 + C4 + C5 + C6 + C7 + C8 + C9 + C10 + (height_prs|GWAv3Caucasian) + (1|MOTHER) + (1|IDM), data = height.data)
summary(prs.fit)

