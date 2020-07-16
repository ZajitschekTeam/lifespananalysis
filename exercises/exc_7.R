###CODEBLOCK 7###

#Load packages and data
suppressMessages((library(dplyr))
suppressMessages((library(lme4))
data1 <- read.csv("Dryad_Zajitschek_etal_2016_ProcB_Data.csv")
data1 <- data1 %>% mutate(across(where(is.integer), as.factor))
          
# Run a GeneralLMM in lme4
lme4_glmm_model1 <- lmer(lifespan ~ cagediet*assaydiet + (1|vial) + (1|cage), data= data1)

# Check results
summary(lme4_glmm_model1)
                        


