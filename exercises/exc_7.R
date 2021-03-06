###CODEBLOCK 7###

#Load packages and data
suppressMessages(library(dplyr))
suppressMessages(library(lme4))
suppressMessages(library(lmerTest))
data1 <- read.csv("https://github.com/ZajitschekTeam/lifespananalysis/raw/master/binder/data/expevol_male_flies.csv")
data1 <- data1 %>% mutate_if(is.integer, as.factor)
          
# Run a General LMM in lme4 

lme4_glmm_model1 <- lmerTest::lmer(lifespan ~ assaydiet + (1|cage/vial), data= subset(data1, cagediet== "1"))

print('--------------Output from: anova(lme4_glmm_model1):---------------------')
print(anova(lme4_glmm_model1))

print('--------------Output from: summary(lme4_glmm_model1):-------------------')
summary(lme4_glmm_model1)

                        


