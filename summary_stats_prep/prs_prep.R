library(data.table)
library(stringr)

# Load HRC map for RS id
hrc_map <- fread("HRC.r1-1.GRCh37.wgs.mac5.sites.tab.rsid_map.gz")
# Create chromosome:position ID
hrc_map$cptid <-  paste(hrc_map$chr, hrc_map$pos, sep = ":")
hrc_map <- hrc_map[ ,.(cptid, rsid)]

### Insomnia
insomnia <- fread("polygenic_scores/original/1200.gwas.imputed_v3.both_sexes.tsv.gz")
# Remove low confidence variants
insomnia <- insomnia[insomnia$low_confidence_variant == F, ]
# Extract chromosome:position ID
insomnia$cptid <-  gsub('^([^:]*:[^:]*).*', '\\1', insomnia$variant)
# Extract effect allele
insomnia$ea <-  gsub('.*\\:', '', insomnia$variant)
# Select only necessary columns
insomnia <- insomnia[,.(cptid,ea,beta,pval)]
# Rename columns
names(insomnia) <- c("cptid","ea","beta","pvalue")
# Merge with RS ID
insomnia <- merge(insomnia, hrc_map, by = "cptid", all.x = T)
# Write base file for PRSice
fwrite(insomnia, file = "polygenic_scores/prs_base/insomnia.txt", sep  = " ", quote = F, row.names = F, na = "NA")
system("gzip polygenic_scores/prs_base/insomnia.txt")

### Social anxiety
soc_anxiety <- fread("polygenic_scores/original/20544_1.gwas.imputed_v3.both_sexes.tsv.gz")
# Remove low confidence variants
soc_anxiety <- soc_anxiety[soc_anxiety$low_confidence_variant == F, ]
# Extract chromosome:position ID
soc_anxiety$cptid <-  gsub('^([^:]*:[^:]*).*', '\\1', soc_anxiety$variant)
# Extract effect allele
soc_anxiety$ea <-  gsub('.*\\:', '', soc_anxiety$variant)
# Select only necessary columns
soc_anxiety <- soc_anxiety[,.(cptid,ea,beta,pval)]
# Rename columns
names(soc_anxiety) <- c("cptid","ea","beta","pvalue")
# Merge with RS ID
soc_anxiety <- merge(soc_anxiety, hrc_map, by = "cptid", all.x = T)
# Write base file for PRSice
fwrite(soc_anxiety, file = "polygenic_scores/prs_base/soc_anxiety.txt", sep  = " ", quote = F, row.names = F, na = "NA")
system("gzip polygenic_scores/prs_base/soc_anxiety.txt")

### Anxiety
anxiety <- fread("polygenic_scores/original/20544_15.gwas.imputed_v3.both_sexes.tsv.gz")
# Remove low confidence variants
anxiety <- anxiety[anxiety$low_confidence_variant == F, ]
# Extract chromosome:position ID
anxiety$cptid <-  gsub('^([^:]*:[^:]*).*', '\\1', anxiety$variant)
# Extract effect allele
anxiety$ea <-  gsub('.*\\:', '', anxiety$variant)
# Select only necessary columns
anxiety <- anxiety[,.(cptid,ea,beta,pval)]
# Rename columns
names(anxiety) <- c("cptid","ea","beta","pvalue")
# Merge with RS ID
anxiety <- merge(anxiety, hrc_map, by = "cptid", all.x = T)
# Write base file for PRSice
fwrite(anxiety, file = "polygenic_scores/prs_base/anxiety.txt", sep  = " ", quote = F, row.names = F, na = "NA")
system("gzip polygenic_scores/prs_base/anxiety.txt")

### Phobia
phobia <- fread("polygenic_scores/original/20544_5.gwas.imputed_v3.both_sexes.tsv.gz")
# Remove low confidence variants
phobia <- phobia[phobia$low_confidence_variant == F, ]
# Extract chromosome:position ID
phobia$cptid <-  gsub('^([^:]*:[^:]*).*', '\\1', phobia$variant)
# Extract effect allele
phobia$ea <-  gsub('.*\\:', '', phobia$variant)
# Select only necessary columns
phobia <- phobia[,.(cptid,ea,beta,pval)]
# Rename columns
names(phobia) <- c("cptid","ea","beta","pvalue")
# Merge with RS ID
phobia <- merge(phobia, hrc_map, by = "cptid", all.x = T)
# Write base file for PRSice
fwrite(phobia, file = "polygenic_scores/prs_base/phobia.txt", sep  = " ", quote = F, row.names = F, na = "NA")
system("gzip polygenic_scores/prs_base/phobia.txt")

### Panic
panic <- fread("polygenic_scores/original/20544_6.gwas.imputed_v3.both_sexes.tsv.gz")
# Remove low confidence variants
panic <- panic[panic$low_confidence_variant == F, ]
# Extract chromosome:position ID
panic$cptid <-  gsub('^([^:]*:[^:]*).*', '\\1', panic$variant)
# Extract effect allele
panic$ea <-  gsub('.*\\:', '', panic$variant)
# Select only necessary columns
panic <- panic[,.(cptid,ea,beta,pval)]
# Rename columns
names(panic) <- c("cptid","ea","beta","pvalue")
# Merge with RS ID
panic <- merge(panic, hrc_map, by = "cptid", all.x = T)
# Write base file for PRSice
fwrite(panic, file = "polygenic_scores/prs_base/panic.txt", sep  = " ", quote = F, row.names = F, na = "NA")
system("gzip polygenic_scores/prs_base/panic.txt")

### ADHD
adhd <- fread("polygenic_scores/original/adhd_jul2017.gz")
# Create chromosome:position ID
adhd$cptid <-  paste(adhd$CHR, adhd$BP, sep = ":")
# Select only necessary columns
adhd <- adhd[,.(cptid,A1,A2,OR,P,SNP)]
# Rename columns
names(adhd) <- c("cptid","ea","oa","or","pvalue","rsid")
# Write base file for PRSice
fwrite(adhd, file = "polygenic_scores/prs_base/adhd.txt", sep  = " ", quote = F, row.names = F, na = "NA")
system("gzip polygenic_scores/prs_base/adhd.txt")

### Alcohol dependence
alcohol <- fread("polygenic_scores/original/pgc_alcdep.aug2018_release/pgc_alcdep.discovery.aug2018_release.txt.gz")
# Create chromosome:position ID
alcohol$cptid <-  paste(alcohol$CHR, alcohol$BP, sep = ":")
# Add RSID
alcohol$rsid <-  gsub(':.*$', "", alcohol$SNP)
# Select only necessary columns
alcohol <- alcohol[,.(cptid,A1,Z,P,rsid)]
# Rename columns
names(alcohol) <- c("cptid","ea","beta","pvalue","rsid")
# Write base file for PRSice
fwrite(alcohol, file = "polygenic_scores/prs_base/alcohol.txt", sep  = " ", quote = F, row.names = F, na = "NA")
system("gzip polygenic_scores/prs_base/alcohol.txt")

### ASD
autism <- fread("polygenic_scores/original/iPSYCH-PGC_ASD_Nov2017.gz")
# Create chromosome:position ID
autism$cptid <-  paste(autism$CHR, autism$BP, sep = ":")
# Select only necessary columns
autism <- autism[,.(cptid,A1,OR,P,SNP)]
# Rename columns
names(autism) <- c("cptid","ea","or","pvalue","rsid")
# Write base file for PRSice
fwrite(autism, file = "polygenic_scores/prs_base/autism.txt", sep  = " ", quote = F, row.names = F, na = "NA")
system("gzip polygenic_scores/prs_base/autism.txt")

### Bipolar
bipolar <- fread("polygenic_scores/original/daner_PGC_BIP32b_mds7a_0416a.gz")
# Create chromosome:position ID
bipolar$cptid <-  paste(bipolar$CHR, bipolar$BP, sep = ":")
# Select only necessary columns
bipolar <- bipolar[,.(cptid,A1,OR,P,SNP)]
# Rename columns
names(bipolar) <- c("cptid","ea","or","pvalue","rsid")
# Write base file for PRSice
fwrite(bipolar, file = "polygenic_scores/prs_base/bipolar.txt", sep  = " ", quote = F, row.names = F, na = "NA")
system("gzip polygenic_scores/prs_base/bipolar.txt")

# ### Bipolar + Schizophrenia
# bipolar_schizophrenia <- fread("polygenic_scores/original/BDSCZvsCONT.sumstats.gz")
# # Create chromosome:position ID
# bipolar_schizophrenia$cptid <-  paste(bipolar_schizophrenia$CHR, bipolar_schizophrenia$BP, sep = ":")
# # Select only necessary columns
# bipolar_schizophrenia <- bipolar_schizophrenia[,.(cptid,A1,OR,P)]
# # Rename columns
# names(bipolar_schizophrenia) <- c("cptid","ea","or","pvalue")
# # Write base file for PRSice
# fwrite(bipolar_schizophrenia, file = "polygenic_scores/prs_base/bipolar_schizophrenia.txt", sep  = " ", quote = F, row.names = F, na = "NA")
# system("gzip polygenic_scores/prs_base/bipolar_schizophrenia.txt")

### Cross
cross <- fread("polygenic_scores/original/pgc.cross.full.2013-03/pgc.cross.full.2013-03.txt")
# Ad chromosome and position to cross dataset based on Build 37
cross <- merge(cross, hrc_map, by.x = "snpid", by.y = "rsid")
# Create chromosome:position ID
cross$cptid <-  paste(cross$chr, cross$pos, sep = ":")
# Select only necessary columns
cross <- cross[,.(cptid,a1,or,pval,snpid)]
# Rename columns
names(cross) <- c("cptid","ea","or","pvalue","rsid")
# Write base file for PRSice
fwrite(cross, file = "polygenic_scores/prs_base/cross.txt", sep  = " ", quote = F, row.names = F, na = "NA")
system("gzip polygenic_scores/prs_base/cross.txt")

### Major depressive disorder
mdd <- fread("polygenic_scores/original/PGC_UKB_depression_genome-wide.txt.gz")
# Load map data to get chromosome position
map <- fread("HRC.r1-1.GRCh37.wgs.mac5.sites.tab.rsid_map")
# Ad chromosome and position to MDD dataset
mdd <- merge(mdd, map, by.x = "MarkerName", by.y = "rsid")
# Create chromosome:position ID
mdd$cptid <-  paste(mdd$chr, mdd$pos, sep = ":")
# Select only necessary columns
mdd <- mdd[,.(cptid,A1,LogOR,P,MarkerName)]
# Rename columns
names(mdd) <- c("cptid","ea","beta","pvalue","rsid")
# Write base file for PRSice
fwrite(mdd, file = "polygenic_scores/prs_base/mdd.txt", sep  = " ", quote = F, row.names = F, na = "NA")
system("gzip polygenic_scores/prs_base/mdd.txt")

### Schizophrenia
sz <- fread("polygenic_scores/original/ckqny.scz2snpres.gz")
# Create chromosome:position ID
sz$cptid <-  paste(sz$hg19chrc, sz$bp, sep = ":")
sz$cptid <- gsub("chr","",sz$cptid)
# Select only necessary columns
sz <- sz[,.(cptid,a1,or,p,snpid)]
# Rename columns
names(sz) <- c("cptid","ea","or","pvalue","rsid")
# Write base file for PRSice
fwrite(sz, file = "polygenic_scores/prs_base/sz.txt", sep  = " ", quote = F, row.names = F, na = "NA")
system("gzip polygenic_scores/prs_base/sz.txt")

# ### Educational attainment
# education <- fread("polygenic_scores/original/GWAS_EA_excl23andMe.txt.gz")
# # Create chromosome:position ID
# education$cptid <-  paste(education$CHR, education$POS, sep = ":")
# # Select only necessary columns
# education <- education[,.(cptid,A1,Beta,Pval)]
# # Rename columns
# names(education) <- c("cptid","ea","beta","pvalue")
# # Write base file for PRSice
# fwrite(education, file = "polygenic_scores/prs_base/education.txt", sep  = " ", quote = F, row.names = F, na = "NA")
# system("gzip polygenic_scores/prs_base/education.txt")

### Depression
depression <- fread("polygenic_scores/original/DS_Full.txt.gz")
# Create chromosome:position ID
depression$cptid <-  paste(depression$CHR, depression$POS, sep = ":")
# Select only necessary columns
depression <- depression[,.(cptid,A1,Beta,Pval,MarkerName)]
# Rename columns
names(depression) <- c("cptid","ea","beta","pvalue","rsid")
# Write base file for PRSice
fwrite(depression, file = "polygenic_scores/prs_base/depression.txt", sep  = " ", quote = F, row.names = F, na = "NA")
system("gzip polygenic_scores/prs_base/depression.txt")

### Cognitive function
cognitive <- fread("polygenic_scores/original/Davies_NC_2018_OPEN_DATASET/Davies2018_OPEN_DATASET_summary_results.txt")
# Create chromosome:position ID
cognitive$cptid <-  paste(cognitive$Chromosome, cognitive$Position, sep = ":")
# Select only necessary columns
cognitive <- cognitive[,c("cptid","Effect_allele","Zscore","P-value","Markername"),with=F]
# Rename columns
names(cognitive) <- c("cptid","ea","beta","pvalue","Markername")
# Write base file for PRSice
fwrite(cognitive, file = "polygenic_scores/prs_base/cognitive.txt", sep  = " ", quote = F, row.names = F, na = "NA")
system("gzip polygenic_scores/prs_base/cognitive.txt")

### Neuroticism
neuroticism <- fread("polygenic_scores/original/Luciano_2017/SummaryStats.txt")
# Create chromosome:position ID
neuroticism$cptid <-  paste(neuroticism$CHR, neuroticism$BP, sep = ":")
# Select only necessary columns
neuroticism <- neuroticism[,.(cptid,a_1,N_res_beta,p_value,rsid)]
# Rename columns
names(neuroticism) <- c("cptid","ea","beta","pvalue","rsid")
# Write base file for PRSice
fwrite(neuroticism, file = "polygenic_scores/prs_base/neuroticism.txt", sep  = " ", quote = F, row.names = F, na = "NA")
system("gzip polygenic_scores/prs_base/neuroticism.txt")

### Total problems
load("polygenic_scores/original/ps_results.Rdata")
# Split chromosome and position
chr_bp <- str_split_fixed(metasoft_results$cptid, ":", 3)
metasoft_results$CHR <- chr_bp[,1]
metasoft_results$BP <- chr_bp[,2]
# Create chromosome:position ID
metasoft_results$cptid <-  paste(metasoft_results$CHR, metasoft_results$BP, sep = ":")
# Select only necessary columns
metasoft_results <- metasoft_results[,.(cptid,ea,beta_fe,p_fe)]
# Merge with RS ID
metasoft_results <- merge(metasoft_results, hrc_map, by = "cptid", all.x = T)
# Rename columns
names(metasoft_results) <- c("cptid","ea","beta","pvalue","rsid")
# Write base file for PRSice
fwrite(metasoft_results, file = "polygenic_scores/prs_base/total_problems.txt", sep  = " ", quote = F, row.names = F, na = "NA")
system("gzip polygenic_scores/prs_base/total_problems.txt")

### Susceptibility
susceptibility <- fread("polygenic_scores/original/anx12_genotyped_comb_mind001_maf001_geno003_snps_genotyped.assoc.linear.A2")
# Create chromosome:position ID
susceptibility$cptid <-  paste(susceptibility$CHR, susceptibility$BP, sep = ":")
# Select only necessary columns
susceptibility <- susceptibility[,.(cptid,A1,BETA,P,SNP)]
# Rename columns
names(susceptibility) <- c("cptid","ea","beta","pvalue","rsid")
# Write base file for PRSice
fwrite(susceptibility, file = "polygenic_scores/prs_base/susceptibility.txt", sep  = " ", quote = F, row.names = F, na = "NA")
system("gzip polygenic_scores/prs_base/susceptibility.txt")

### Alzheimer SNPs
# Load LD pruned SNPs
alz_snps.data <- fread("prs/alzheimer.snps")
names(alz_snps.data) <- c("cptid","chr","pos","p","hit")
# Load base summary stats for PRS calculation
alz_prs_base.data <- fread("prs_base/alzheimer.txt.gz")
# Select SNPs below p-values threshold
alz_prs_base_p.data <- alz_prs_base.data[alz_prs_base.data$pvalue < 0.000035, ]
# Select only SNPs not in LD
alz_prs_base_p_ld.data <- merge(alz_prs_base_p.data, alz_snps.data, by = "cptid")
# Add SNP names
alz_prs_base_p_ld_snp_name.data <- merge(alz_prs_base_p_ld.data, hrc_map)
# Write formatted SNP list
fwrite(alz_prs_base_p_ld_snp_name.data[,.(cptid, rsid, ea, beta, pvalue)],"prs/alz_snp_list.csv")

### Height
height <- fread("gwas_summary/GIANT_HEIGHT_YENGO_2022_PGS_WEIGHTS_ALL.gz")
# Create chromosome:position ID
height$cptid <-  paste(height$CHR, height$POS, sep = ":")
# Select only necessary columns
height <- height[,.(cptid,PGS_EFFECT_ALLELE,PGS_WEIGHT)]
# Write base file for PRSice
fwrite(height, file = "prs_base/height.txt", sep  = " ", quote = F, row.names = F, na = "NA")
system("gzip polygenic_scores/prs_base/neuroticism.txt")

