---
title: "T-Test in Practice"
author: "Anna STachel"
date: "January 4, 2016"
output: html_document
---


# Showing t-test/t-distrubution concepts.


#install.packages("rmarkdown")
library(dplyr)


# *Import Dataset

FemaleMiceWeight <- read.csv("femaleMiceWeights.csv") #previously downloaded

# *Create control and treatment dataset

control <- filter(FemaleMiceWeight,Diet=="chow") %>% select(Bodyweight) %>% unlist
treatment <- filter(FemaleMiceWeight,Diet=="hf") %>% select(Bodyweight) %>% unlist

# *Find the mean difference

diff <- mean(treatment) - mean(control)
print(diff)


# *Find the standard error for population (standard deviation of population divided by the square root of sample size)

sd(control)/sqrt(length(control))

# *Find the standard error of the difference between treatment and control (variance of difference is equal to sum of it's variances)

se <- sqrt(var(treatment)/length(treatment) + 
  var(control)/length(control))
  
# *t statistic
  
tstat <- diff/se

# *pvalue

righttail <- 1 - pnorm(abs(tstat)) 
lefttail <- pnorm(-abs(tstat))
pval <- lefttail + righttail
print(pval)

# T-dsitribution in Practice
# To use CLT to deterime statistical difference you need to know if the sample is normal. (Small samples may be hard to test if normal).  QQplots for samples can help show if the sample follows a t-dsitrubtion. 
# *raflib is hosted on CRAN to create plots

library(rafalib)
mypar(1,2)

FemaleMiceWeight <- read.csv("femaleMiceWeights.csv") #previously downloaded

control <- filter(FemaleMiceWeight,Diet=="chow") %>% select(Bodyweight) %>% unlist
treatment <- filter(FemaleMiceWeight,Diet=="hf") %>% select(Bodyweight) %>% unlist


qqnorm(treatment)
qqline(treatment,col=2)

qqnorm(control)
qqline(control,col=2)


# T-distrubition is more complicated than a normal distrubtion.  The t-distrbution has a location parameter like the normal but also uses degrees of freedm. R can compute it.

# *t-distribution

t.test(treatment, control)

Result <- t.test(treatment, control)
Result$p.value

# P-value is bigger than the "tstat" test pvalue.  Tstat uses CLT which approximates normal distrubution while the t-distrubution takes the SE of the difference into account.  CLT is more likely to incorrectly reject the null hypothesis (Type 1 error) and T-distribution is more likely to not reject the null (Type II error)




library(dplyr)
MicePheno <- read.csv("mice_pheno.csv")
control <- filter(MicePheno ,Diet=="chow") %>% select(Bodyweight) 
treatment <- filter(MicePheno ,Diet=="hf") %>% select(Bodyweight) 


# ??? Why are there warning messages with the following code, Character variable? ???

diff <- mean(treatment) - mean(control)
print(diff)

sd(control)/sqrt(length(control))

se <- sqrt(var(treatment)/length(treatment) + 
  var(control)/length(control))
  
tstat <- diff/se

# Using T-distribution

t.test(treatment,control)


