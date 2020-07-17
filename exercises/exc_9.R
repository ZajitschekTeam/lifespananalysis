###CODEBLOCK 9###

#Load packages and data
suppressMessages((library(rstanarm))
data1 <- read.csv("expevol_male_flies.csv")
data1 <- data1 %>% mutate(across(where(is.integer), as.factor))
          
# Bayesian model
stan_glmm_model1 <- stan_lmer(lifespan ~ assaydiet + (1|vial), data= data1, seed= 111)
plot(stan_glmm_model1)
summary(stan_glmm_model1)

summary(stan_glmm_model1, 
        pars = c("(Intercept)", "assaydiet3", "assaydiet4"),
        probs = c(0.025, 0.975),
        digits = 2)

# Try out the following on your local computer only
#library(shinystan)
#launch_shinystan(stan_glmm_model1)  
                        


