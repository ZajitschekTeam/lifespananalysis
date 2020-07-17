###CODEBLOCK 7###

#Load packages and data
suppressMessages((library(dplyr))
suppressMessages((library(lme4))
suppressMessages((library(lmerTest))
data1 <- read.csv("expevol_male_flies.csv")
data1 <- data1 %>% mutate(across(where(is.integer), as.factor))
          
# Run a GeneralLMM in lme4
lme4_glmm_model1 <- lmerTest::lmer(lifespan ~ cagediet*assaydiet + (1|cage/vial), data= subset(data1, cagediet== "1")
anova(lme4_glmm_model1)
summary(lme4_glmm_model1)

                        


