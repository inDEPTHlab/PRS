

```r
library(foreign)
library(metafor)

### Load GenR3 data
# PRS
prs_bw_genr3.data <- read.csv("data/LDpgs_BW_GENR3_271123.csv")
names(prs_bw_genr3.data) <- c("IDC","prs_bw")
# Selection
selection_genr3.data <- read.spss("data/SelectionGWAv3_October2022.sav", to.data.frame = T)
```

```r
# PCA
pca_genr3.data <- read.spss("data/PCA_Selection GWAv3_revised def_October2022.sav", to.data.frame = T)
```

```r
table(pca_genr3.data$IDC %in% selection_genr3.data$IDC) # Check whether PCA file has IDs not in selection
```

```
## 
## TRUE 
## 5700
```

```r
# General data
general.data <- read.spss("data/CHILD-ALLGENERALDATA_15012024.sav", to.data.frame = T)
```

```r
# Merge all data
bw_genr3.data <-  Reduce(function(x, y) merge(x, y, all=F, by = "IDC"), list(prs_bw_genr3.data, pca_genr3.data, general.data))
dim(bw_genr3.data)
```

```
## [1] 5700  145
```

```r
### Load GenR4 data
# PRS
prs_bw_genr4.data <- read.csv("data/LDpgs_BW_GENR4_271123.csv")
names(prs_bw_genr4.data) <- c("IDC","prs_bw")
# Selection
selection_genr4.data <- read.spss("data/Selection_GWAv4-Child_October2022.sav", to.data.frame = T)
# PCA
pca_genr4.data <- read.spss("data/PCA_Selection GWAv4_revised def_October2022.sav", to.data.frame = T)
table(pca_genr4.data$IDC %in% selection_genr4.data$IDC) # Check whether PCA file has IDs not in selection
```

```
## 
## TRUE 
## 1802
```

```r
# Merge all data
bw_genr4.data <-  Reduce(function(x, y) merge(x, y, all=F, by = "IDC"), list(prs_bw_genr4.data, pca_genr4.data, general.data))
dim(bw_genr4.data)
```

```
## [1] 1802  144
```

```r
# Distributions PRS, outcome, gestational age and ancestry (just for checking heterogeneity)
quantile(bw_genr3.data$prs_bw)
```

```
##          0%         25%         50%         75%        100% 
## -1.07214814 -0.29548170 -0.11866999  0.06422452  0.90227421
```

```r
quantile(bw_genr4.data$prs_bw)
```

```
##         0%        25%        50%        75%       100% 
## -0.9575968 -0.2943639 -0.1107772  0.0589435  0.8708647
```

```r
quantile(bw_genr3.data$WEIGHT, na.rm = T)
```

```
##   0%  25%  50%  75% 100% 
##  650 3110 3450 3800 5260
```

```r
quantile(bw_genr4.data$WEIGHT, na.rm = T)
```

```
##   0%  25%  50%  75% 100% 
##  780 3000 3360 3720 5350
```

```r
quantile(bw_genr3.data$GESTBIR, na.rm = T)
```

```
##       0%      25%      50%      75%     100% 
## 25.28571 39.14286 40.14286 41.00000 43.57143
```

```r
quantile(bw_genr4.data$GESTBIR, na.rm = T)
```

```
##       0%      25%      50%      75%     100% 
## 26.28571 38.57143 39.85714 40.85714 43.14286
```

```r
prop.table(table(pca_genr3.data$GWAv3European))
```

```
## 
## Non-European     European 
##    0.4236842    0.5763158
```

```r
prop.table(table(pca_genr4.data$GWAv4European))
```

```
## 
## Non-European     European 
##    0.4311876    0.5688124
```

```r
###### Approach 1: Meta-analysis
# GenR3 analysis
bw_prs_genr3.fit <- lm(WEIGHT ~ scale(prs_bw) + GENDER + C1 + C2 + C3 + C4 + C5 + C6 + C7 + C8 + C9 + C10, data = bw_genr3.data)
summary(bw_prs_genr3.fit)
```

```
## 
## Call:
## lm(formula = WEIGHT ~ scale(prs_bw) + GENDER + C1 + C2 + C3 + 
##     C4 + C5 + C6 + C7 + C8 + C9 + C10, data = bw_genr3.data)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -2867.97  -282.84    10.47   307.55  1750.63 
## 
## Coefficients:
##                Estimate Std. Error t value Pr(>|t|)    
## (Intercept)    3502.986      8.833 396.563  < 2e-16 ***
## scale(prs_bw)   198.552      6.933  28.640  < 2e-16 ***
## GENDERgirl     -111.825     12.578  -8.890  < 2e-16 ***
## C1             -470.382    210.428  -2.235   0.0254 *  
## C2             1767.016    382.637   4.618 3.96e-06 ***
## C3             2073.833    423.418   4.898 9.96e-07 ***
## C4            -4154.348    597.798  -6.949 4.08e-12 ***
## C5             -270.648    724.938  -0.373   0.7089    
## C6            -2515.912   1032.638  -2.436   0.0149 *  
## C7            -1342.902   1163.329  -1.154   0.2484    
## C8             2364.977   1405.806   1.682   0.0926 .  
## C9             1191.409   1469.916   0.811   0.4177    
## C10            1518.102   1354.422   1.121   0.2624    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 473.8 on 5675 degrees of freedom
##   (12 observations deleted due to missingness)
## Multiple R-squared:  0.1796,	Adjusted R-squared:  0.1778 
## F-statistic: 103.5 on 12 and 5675 DF,  p-value: < 2.2e-16
```

```r
bw_prs_genr3_coef <- coef(summary(bw_prs_genr3.fit))[2,"Estimate"]
bw_prs_genr3_se <- coef(summary(bw_prs_genr3.fit))[2,"Std. Error"]

# GenR4 analysis
bw_prs_genr4.fit <- lm(WEIGHT ~ scale(prs_bw) + GENDER + C1 + C2 + C3 + C4 + C5 + C6 + C7 + C8 + C9 + C10, data = bw_genr4.data)
summary(bw_prs_genr4.fit)
```

```
## 
## Call:
## lm(formula = WEIGHT ~ scale(prs_bw) + GENDER + C1 + C2 + C3 + 
##     C4 + C5 + C6 + C7 + C8 + C9 + C10, data = bw_genr4.data)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -2736.3  -312.7    48.9   358.9  1856.2 
## 
## Coefficients:
##               Estimate Std. Error t value Pr(>|t|)    
## (Intercept)    3421.70      19.99 171.153  < 2e-16 ***
## scale(prs_bw)   119.82      16.52   7.254 6.00e-13 ***
## GENDERgirl     -187.20      29.01  -6.452 1.42e-10 ***
## C1            -1001.13     493.67  -2.028 0.042717 *  
## C2              444.82     789.60   0.563 0.573271    
## C3             2601.46     968.20   2.687 0.007279 ** 
## C4            -4064.85    1226.59  -3.314 0.000938 ***
## C5              -93.42    1619.71  -0.058 0.954013    
## C6              849.86    2276.76   0.373 0.708987    
## C7             1315.73    2728.73   0.482 0.629740    
## C8             8874.65    2849.87   3.114 0.001875 ** 
## C9              899.17    2730.24   0.329 0.741939    
## C10            4040.29    3261.59   1.239 0.215603    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 611.1 on 1779 degrees of freedom
##   (10 observations deleted due to missingness)
## Multiple R-squared:  0.08255,	Adjusted R-squared:  0.07636 
## F-statistic: 13.34 on 12 and 1779 DF,  p-value: < 2.2e-16
```

```r
bw_prs_genr4_coef <- coef(summary(bw_prs_genr4.fit))[2,"Estimate"]
bw_prs_genr4_se <- coef(summary(bw_prs_genr4.fit))[2,"Std. Error"]

# Meta-analysis (fixed effect)
meta_fixed.fit <- rma(yi = c(bw_prs_genr3_coef, bw_prs_genr4_coef), se = c(bw_prs_genr3_se,bw_prs_genr4_se), method="FE")
summary(meta_fixed.fit)
```

```
## 
## Fixed-Effects Model (k = 2)
## 
##   logLik  deviance       AIC       BIC      AICc   
## -16.2362   19.3152   34.4723   33.1655   38.4723   
## 
## I^2 (total heterogeneity / total variability):   94.82%
## H^2 (total variability / sampling variability):  19.32
## 
## Test for Heterogeneity:
## Q(df = 1) = 19.3152, p-val < .0001
## 
## Model Results:
## 
## estimate      se     zval    pval     ci.lb     ci.ub      
## 186.7603  6.3925  29.2156  <.0001  174.2313  199.2893  *** 
## 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
# Meta-analysis (random effect)
meta_random.fit <- rma(yi = c(bw_prs_genr3_coef, bw_prs_genr4_coef), se = c(bw_prs_genr3_se,bw_prs_genr4_se))
summary(meta_random.fit)
```

```
## 
## Random-Effects Model (k = 2; tau^2 estimator: REML)
## 
##   logLik  deviance       AIC       BIC      AICc   
##  -5.4384   10.8767   14.8767   10.8767   26.8767   
## 
## tau^2 (estimated amount of total heterogeneity): 2938.6035 (SE = 4382.7178)
## tau (square root of estimated tau^2 value):      54.2089
## I^2 (total heterogeneity / total variability):   94.82%
## H^2 (total variability / sampling variability):  19.32
## 
## Test for Heterogeneity:
## Q(df = 1) = 19.3152, p-val < .0001
## 
## Model Results:
## 
## estimate       se    zval    pval    ci.lb     ci.ub      
## 160.6155  39.3381  4.0829  <.0001  83.5142  237.7168  *** 
## 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
###### Approach 2: Z-score standardize and residualize
# GenR3
bw_genr3.data$bw_prs_z_resids <- resid(lm(scale(prs_bw) ~ C1 + C2 + C3 + C4 + C5 + C6 + C7 + C8 + C9 + C10, data = bw_genr3.data))
# Sanity check, whether equivalent to covariate adjustment in one model
summary(lm(WEIGHT ~ bw_prs_z_resids + GENDER, data = bw_genr3.data))
```

```
## 
## Call:
## lm(formula = WEIGHT ~ bw_prs_z_resids + GENDER, data = bw_genr3.data)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -2939.70  -297.66    17.47   327.72  1707.24 
## 
## Coefficients:
##                 Estimate Std. Error t value Pr(>|t|)    
## (Intercept)     3503.918      9.081 385.852   <2e-16 ***
## bw_prs_z_resids  198.652      7.133  27.851   <2e-16 ***
## GENDERgirl      -112.813     12.927  -8.727   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 487.4 on 5685 degrees of freedom
##   (12 observations deleted due to missingness)
## Multiple R-squared:   0.13,	Adjusted R-squared:  0.1297 
## F-statistic: 424.9 on 2 and 5685 DF,  p-value: < 2.2e-16
```

```r
# GenR4
bw_genr4.data$bw_prs_z_resids <- resid(lm(scale(prs_bw) ~ C1 + C2 + C3 + C4 + C5 + C6 + C7 + C8 + C9 + C10, data = bw_genr4.data))
# Sanity check, whether equivalent to covariate adjustment in one model
summary(lm(WEIGHT ~ bw_prs_z_resids + GENDER, data = bw_genr4.data))
```

```
## 
## Call:
## lm(formula = WEIGHT ~ bw_prs_z_resids + GENDER, data = bw_genr4.data)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -2564.15  -323.87    50.08   377.37  1886.72 
## 
## Coefficients:
##                 Estimate Std. Error t value Pr(>|t|)    
## (Intercept)      3425.99      20.18 169.732  < 2e-16 ***
## bw_prs_z_resids   120.00      16.75   7.162 1.16e-12 ***
## GENDERgirl       -196.74      29.33  -6.709 2.62e-11 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 619.8 on 1789 degrees of freedom
##   (10 observations deleted due to missingness)
## Multiple R-squared:  0.05073,	Adjusted R-squared:  0.04966 
## F-statistic:  47.8 on 2 and 1789 DF,  p-value: < 2.2e-16
```

```r
# GenR combined
bw_z_resids.data <- rbind(bw_genr3.data[c("WEIGHT","GENDER","bw_prs_z_resids")], bw_genr4.data[c("WEIGHT","GENDER","bw_prs_z_resids")])
summary(lm(WEIGHT ~ bw_prs_z_resids + GENDER, data = bw_z_resids.data))
```

```
## 
## Call:
## lm(formula = WEIGHT ~ bw_prs_z_resids + GENDER, data = bw_z_resids.data)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -2912.9  -302.7    26.4   342.9  1799.7 
## 
## Coefficients:
##                 Estimate Std. Error t value Pr(>|t|)    
## (Intercept)     3484.769      8.500  409.96   <2e-16 ***
## bw_prs_z_resids  180.844      6.764   26.73   <2e-16 ***
## GENDERgirl      -131.267     12.159  -10.80   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 525.6 on 7477 degrees of freedom
##   (22 observations deleted due to missingness)
## Multiple R-squared:  0.09974,	Adjusted R-squared:  0.0995 
## F-statistic: 414.2 on 2 and 7477 DF,  p-value: < 2.2e-16
```

