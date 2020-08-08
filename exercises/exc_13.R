###CODEBLOCK 12###

#Load packages and data
suppressMessages(library(dplyr))
suppressMessages(library(survival))
suppressMessages(library(survminer))
data1 <- read.csv("https://github.com/ZajitschekTeam/lifespananalysis/raw/master/binder/data/expevol_male_flies.csv")
data1 <- data1 %>% mutate_if(is.integer, as.factor)
data1$status <- 1

# Create a subset of three treatment groups/cohorts 
# (3 assay diets (= all that are available) from 1 cagediet)
group1 <- subset(data1, cagediet== 1)
          
# Fixed effect Cox PH model again

surv_cph1 <- coxph(Surv(lifespan, status)~ assaydiet, data= group1)
summary(surv_cph1)

# Cox PH model with clustering

surv_cph_cluster <- coxph(Surv(lifespan, status)~ assaydiet + cluster(cage), data= group1)
summary(surv_cph_cluster)

# Mixed Cox PH model with frailty term in package 'survival'

surv_cph_frailty <- coxph(Surv(lifespan, status)~ assaydiet + frailty(cage), data= group1)
summary(surv_cph_frailty)

# Mixed Cox PH model in package 'coxme'

surv_cph_mixed <- coxme(Surv(lifespan, status)~ assaydiet + (1|cage), data= group1)
surv_cph_mixed  # don't use summary() for coxme models; just print



                        


