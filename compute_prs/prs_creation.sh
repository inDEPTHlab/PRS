### Insomnia
Rscript prsice/PRSice.R --dir . \
--prsice prsice/PRSice_linux \
--base  prs_base/insomnia.txt.gz \
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
--out prs/insomnia \
--bar-levels 0.5,0.4,0.3,0.2,0.1,0.05,0.01,0.001,0.0001,0.00001,0.000001,0.0000001,0.00000005,0.00000001 \
--fastscore

### Social anxiety
Rscript prsice/PRSice.R --dir . \
--prsice prsice/PRSice_linux \
--base  prs_base/soc_anxiety.txt.gz \
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
--out prs/soc_anxiety \
--bar-levels 0.5,0.4,0.3,0.2,0.1,0.05,0.01,0.001,0.0001,0.00001,0.000001,0.0000001,0.00000005,0.00000001 \
--fastscore

### Anxiety
Rscript prsice/PRSice.R --dir . \
--prsice prsice/PRSice_linux \
--base  prs_base/anxiety.txt.gz \
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
--out prs/anxiety \
--bar-levels 0.5,0.4,0.3,0.2,0.1,0.05,0.01,0.001,0.0001,0.00001,0.000001,0.0000001,0.00000005,0.00000001 \
--fastscore

### Phobia
Rscript prsice/PRSice.R --dir . \
--prsice prsice/PRSice_linux \
--base  prs_base/phobia.txt.gz \
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
--out prs/phobia \
--bar-levels 0.5,0.4,0.3,0.2,0.1,0.05,0.01,0.001,0.0001,0.00001,0.000001,0.0000001,0.00000005,0.00000001 \
--fastscore

### Panic
Rscript prsice/PRSice.R --dir . \
--prsice prsice/PRSice_linux \
--base  prs_base/panic.txt.gz \
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
--out prs/panic \
--bar-levels 0.5,0.4,0.3,0.2,0.1,0.05,0.01,0.001,0.0001,0.00001,0.000001,0.0000001,0.00000005,0.00000001 \
--fastscore

### ADHD
Rscript prsice/PRSice.R --dir . \
--prsice prsice/PRSice_linux \
--base  prs_base/adhd.txt.gz \
--beta F \
--snp cptid \
--A1  ea \
--stat or \
--pvalue pvalue \
--target hrc_bestguess/chr# \
--binary-target F \
--pheno-file gpf.pheno \
--ignore-fid \
--thread 12 \
--all-score \
--out prs/adhd \
--bar-levels 0.5,0.4,0.3,0.2,0.1,0.05,0.01,0.001,0.0001,0.00001,0.000001,0.0000001,0.00000005,0.00000001 \
--fastscore

### Alcohol dependence
Rscript prsice/PRSice.R --dir . \
--prsice prsice/PRSice_linux \
--base  prs_base/alcohol.txt.gz \
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
--out prs/alcohol \
--bar-levels 0.5,0.4,0.3,0.2,0.1,0.05,0.01,0.001,0.0001,0.00001,0.000001,0.0000001,0.00000005,0.00000001 \
--fastscore

### ASD
Rscript prsice/PRSice.R --dir . \
--prsice prsice/PRSice_linux \
--base  prs_base/autism.txt.gz \
--beta F \
--snp cptid \
--A1  ea \
--stat or \
--pvalue pvalue \
--target hrc_bestguess/chr# \
--binary-target F \
--pheno-file gpf.pheno \
--ignore-fid \
--thread 12 \
--all-score \
--out prs/autism \
--bar-levels 0.5,0.4,0.3,0.2,0.1,0.05,0.01,0.001,0.0001,0.00001,0.000001,0.0000001,0.00000005,0.00000001 \
--fastscore

### Bipolar
Rscript prsice/PRSice.R --dir . \
--prsice prsice/PRSice_linux \
--base  prs_base/bipolar.txt.gz \
--beta F \
--snp cptid \
--A1  ea \
--stat or \
--pvalue pvalue \
--target hrc_bestguess/chr# \
--binary-target F \
--pheno-file gpf.pheno \
--ignore-fid \
--thread 12 \
--all-score \
--out prs/bipolar \
--bar-levels 0.5,0.4,0.3,0.2,0.1,0.05,0.01,0.001,0.0001,0.00001,0.000001,0.0000001,0.00000005,0.00000001 \
--fastscore

# ### Bipolar + Schizophrenia
# Rscript prsice/PRSice.R --dir . \
# --prsice prsice/PRSice_linux \
# --base  prs_base/bipolar_schizophrenia.txt.gz \
# --beta F \
# --snp cptid \
# --A1  ea \
# --stat or \
# --pvalue pvalue \
# --target hrc_bestguess/chr# \
# --binary-target F \
# --pheno-file gpf.pheno \
# --ignore-fid \
# --thread 12 \
# --all-score \
# --out prs/bipolar_schizophrenia \
# --bar-levels 0.5,0.4,0.3,0.2,0.1,0.05,0.01,0.001,0.0001,0.00001,0.000001,0.0000001,0.00000005,0.00000001 \
# --fastscore

### Cross
Rscript prsice/PRSice.R --dir . \
--prsice prsice/PRSice_linux \
--base  prs_base/cross.txt.gz \
--beta F \
--snp cptid \
--A1  ea \
--stat or \
--pvalue pvalue \
--target hrc_bestguess/chr# \
--binary-target F \
--pheno-file gpf.pheno \
--ignore-fid \
--thread 12 \
--all-score \
--out prs/cross \
--bar-levels 0.5,0.4,0.3,0.2,0.1,0.05,0.01,0.001,0.0001,0.00001,0.000001,0.0000001,0.00000005,0.00000001 \
--fastscore

### Major depressive disorder
Rscript prsice/PRSice.R --dir . \
--prsice prsice/PRSice_linux \
--base  prs_base/mdd.txt.gz \
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
--out prs/mdd \
--bar-levels 0.5,0.4,0.3,0.2,0.1,0.05,0.01,0.001,0.0001,0.00001,0.000001,0.0000001,0.00000005,0.00000001 \
--fastscore

### Schizophrenia
Rscript prsice/PRSice.R --dir . \
--prsice prsice/PRSice_linux \
--base  prs_base/sz.txt.gz \
--beta F \
--snp cptid \
--A1  ea \
--stat or \
--pvalue pvalue \
--target hrc_bestguess/chr# \
--binary-target F \
--pheno-file gpf.pheno \
--ignore-fid \
--thread 12 \
--all-score \
--out prs/sz \
--bar-levels 0.5,0.4,0.3,0.2,0.1,0.05,0.01,0.001,0.0001,0.00001,0.000001,0.0000001,0.00000005,0.00000001 \
--fastscore

# ### Educational attainment
# Rscript prsice/PRSice.R --dir . \
# --prsice prsice/PRSice_linux \
# --base  prs_base/education.txt.gz \
# --beta T \
# --snp cptid \
# --A1  ea \
# --stat beta \
# --pvalue pvalue \
# --target hrc_bestguess/chr# \
# --binary-target F \
# --pheno-file gpf.pheno \
# --ignore-fid \
# --thread 12 \
# --all-score \
# --out prs/education \
# --bar-levels 0.5,0.4,0.3,0.2,0.1,0.05,0.01,0.001,0.0001,0.00001,0.000001,0.0000001,0.00000005,0.00000001 \
# --fastscore

### Depression
Rscript prsice/PRSice.R --dir . \
--prsice prsice/PRSice_linux \
--base  prs_base/depression.txt.gz \
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
--out prs/depression \
--bar-levels 0.5,0.4,0.3,0.2,0.1,0.05,0.01,0.001,0.0001,0.00001,0.000001,0.0000001,0.00000005,0.00000001 \
--fastscore

### Cognitive function
Rscript prsice/PRSice.R --dir . \
--prsice prsice/PRSice_linux \
--base  prs_base/cognitive.txt.gz \
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
--out prs/cognitive \
--bar-levels 0.5,0.4,0.3,0.2,0.1,0.05,0.01,0.001,0.0001,0.00001,0.000001,0.0000001,0.00000005,0.00000001 \
--fastscore

### Neuroticism
Rscript prsice/PRSice.R --dir . \
--prsice prsice/PRSice_linux \
--base  prs_base/neuroticism.txt.gz \
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
--out prs/neuroticism \
--bar-levels 0.5,0.4,0.3,0.2,0.1,0.05,0.01,0.001,0.0001,0.00001,0.000001,0.0000001,0.00000005,0.00000001 \
--fastscore

### Total problems
Rscript prsice/PRSice.R --dir . \
--prsice prsice/PRSice_linux \
--base  prs_base/total_problems.txt.gz \
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
--out prs/total_problems \
--bar-levels 0.5,0.4,0.3,0.2,0.1,0.05,0.01,0.001,0.0001,0.00001,0.000001,0.0000001,0.00000005,0.00000001 \
--fastscore

### Susceptibility
Rscript prsice/PRSice.R --dir . \
--prsice prsice/PRSice_linux \
--base  prs_base/susceptibility.txt.gz \
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
--out prs/susceptibility \
--bar-levels 0.5,0.4,0.3,0.2,0.1,0.05,0.01,0.001,0.0001,0.00001,0.000001,0.0000001,0.00000005,0.00000001 \
--fastscore
