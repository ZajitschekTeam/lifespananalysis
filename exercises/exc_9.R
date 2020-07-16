###CODEBLOCK 9###

#Load packages and data
suppressMessages((library(dplyr))
suppressMessages((library(lme4))
suppressMessages((library(lmerTest))
data1 <- read.csv("expevol_male_flies.csv")
data1 <- data1 %>% mutate(across(where(is.integer), as.factor))
          
# Remove random intercept for 'cage' ((1|cage)
lme4_glmm_model2 <- lmer(lifespan ~ cagediet*assaydiet + (1|vial) , data= data1)

# Check results with package lmerTest loaded
summary(lme4_glmm_model2) # with default Satterthwaite's method for df and t-tests
summary(lme4_glmm_model3, ddf="Kenward-Roger")

# Examples of diagnostic plots 
plot(lme4_glmm_model2)
qqnorm(residuals(lme4_glmm_model2))
                        


