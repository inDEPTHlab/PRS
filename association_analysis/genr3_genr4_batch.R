library(foreign)
library(metafor)

### Load GenR3 data
# PRS
prs_bw_genr3.data <- read.csv("data/LDpgs_BW_GENR3_271123.csv")
names(prs_bw_genr3.data) <- c("IDC","prs_bw")
# Selection
selection_genr3.data <- read.spss("data/SelectionGWAv3_October2022.sav", to.data.frame = T)
# PCA
pca_genr3.data <- read.spss("data/PCA_Selection GWAv3_revised def_October2022.sav", to.data.frame = T)
table(pca_genr3.data$IDC %in% selection_genr3.data$IDC) # Check whether PCA file has IDs not in selection
# General data
general.data <- read.spss("data/CHILD-ALLGENERALDATA_15012024.sav", to.data.frame = T)
# Merge all data
bw_genr3.data <-  Reduce(function(x, y) merge(x, y, all=F, by = "IDC"), list(prs_bw_genr3.data, pca_genr3.data, general.data))
dim(bw_genr3.data)

### Load GenR4 data
# PRS
prs_bw_genr4.data <- read.csv("data/LDpgs_BW_GENR4_271123.csv")
names(prs_bw_genr4.data) <- c("IDC","prs_bw")
# Selection
selection_genr4.data <- read.spss("data/Selection_GWAv4-Child_October2022.sav", to.data.frame = T)
# PCA
pca_genr4.data <- read.spss("data/PCA_Selection GWAv4_revised def_October2022.sav", to.data.frame = T)
table(pca_genr4.data$IDC %in% selection_genr4.data$IDC) # Check whether PCA file has IDs not in selection
# Merge all data
bw_genr4.data <-  Reduce(function(x, y) merge(x, y, all=F, by = "IDC"), list(prs_bw_genr4.data, pca_genr4.data, general.data))
dim(bw_genr4.data)

# Distributions PRS, outcome, gestational age and ancestry (just for checking heterogeneity)
quantile(bw_genr3.data$prs_bw)
quantile(bw_genr4.data$prs_bw)

quantile(bw_genr3.data$WEIGHT, na.rm = T)
quantile(bw_genr4.data$WEIGHT, na.rm = T)

quantile(bw_genr3.data$GESTBIR, na.rm = T)
quantile(bw_genr4.data$GESTBIR, na.rm = T)

prop.table(table(pca_genr3.data$GWAv3European))
prop.table(table(pca_genr4.data$GWAv4European))

###### Approach 1: Meta-analysis
# GenR3 analysis
bw_prs_genr3.fit <- lm(WEIGHT ~ scale(prs_bw) + GENDER + C1 + C2 + C3 + C4 + C5 + C6 + C7 + C8 + C9 + C10, data = bw_genr3.data)
summary(bw_prs_genr3.fit)
bw_prs_genr3_coef <- coef(summary(bw_prs_genr3.fit))[2,"Estimate"]
bw_prs_genr3_se <- coef(summary(bw_prs_genr3.fit))[2,"Std. Error"]

# GenR4 analysis
bw_prs_genr4.fit <- lm(WEIGHT ~ scale(prs_bw) + GENDER + C1 + C2 + C3 + C4 + C5 + C6 + C7 + C8 + C9 + C10, data = bw_genr4.data)
summary(bw_prs_genr4.fit)
bw_prs_genr4_coef <- coef(summary(bw_prs_genr4.fit))[2,"Estimate"]
bw_prs_genr4_se <- coef(summary(bw_prs_genr4.fit))[2,"Std. Error"]

# Meta-analysis (fixed effect)
meta_fixed.fit <- rma(yi = c(bw_prs_genr3_coef, bw_prs_genr4_coef), se = c(bw_prs_genr3_se,bw_prs_genr4_se), method="FE")
summary(meta_fixed.fit)

# Meta-analysis (random effect)
meta_random.fit <- rma(yi = c(bw_prs_genr3_coef, bw_prs_genr4_coef), se = c(bw_prs_genr3_se,bw_prs_genr4_se))
summary(meta_random.fit)


###### Approach 2: Z-score standardize and residualize
# GenR3
bw_genr3.data$bw_prs_z_resids <- resid(lm(scale(prs_bw) ~ C1 + C2 + C3 + C4 + C5 + C6 + C7 + C8 + C9 + C10, data = bw_genr3.data))
# Sanity check, whether equivalent to covariate adjustment in one model
summary(lm(WEIGHT ~ bw_prs_z_resids + GENDER, data = bw_genr3.data))

# GenR4
bw_genr4.data$bw_prs_z_resids <- resid(lm(scale(prs_bw) ~ C1 + C2 + C3 + C4 + C5 + C6 + C7 + C8 + C9 + C10, data = bw_genr4.data))
# Sanity check, whether equivalent to covariate adjustment in one model
summary(lm(WEIGHT ~ bw_prs_z_resids + GENDER, data = bw_genr4.data))

# GenR combined
bw_z_resids.data <- rbind(bw_genr3.data[c("WEIGHT","GENDER","bw_prs_z_resids")], bw_genr4.data[c("WEIGHT","GENDER","bw_prs_z_resids")])
summary(lm(WEIGHT ~ bw_prs_z_resids + GENDER, data = bw_z_resids.data))


