###CODEBLOCK 8###

#Load packages and data
suppressMessages(library(dplyr))
suppressMessages(library(lme4))
suppressMessages(library(lmerTest))
data1 <- read.csv("https://github.com/ZajitschekTeam/lifespananalysis/raw/master/binder/data/expevol_male_flies.csv")
data1 <- data1 %>% mutate(across(where(is.integer), as.factor))
          
# Analysis of all data, including cagediet and its interaction term with assaydiet
lme4_glmm_model2 <- lmer(lifespan ~ cagediet*assaydiet + (1|cage/vial) , data= data1)

# Check results with package lmerTest loaded
anova(lme4_glmm_model2) # with default Satterthwaite's method for df and t-tests

summary(lme4_glmm_model2)

# Examples of diagnostic plots 
plot(lme4_glmm_model2)
qqnorm(residuals(lme4_glmm_model2))
                        


