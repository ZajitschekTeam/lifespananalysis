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
          
# Run a Cox Proportional Hazards model (CoxPH)

surv_cph1 <- coxph(Surv(lifespan, status)~ assaydiet, data= group1)

summary(surv_cph1)

# Test of proportional hazards assumption

cox.zph(surv_cph1) 

ggcoxzph(cox.zph(surv_cph1))  # based on plot.cox.ph

# Forest plot for Cox PH model

ggforest(surv_cph1)  


# Plot survival curves

surv1 <- survfit(Surv(lifespan, status)~ assaydiet, data= group1)
ggsurvplot(surv1, size= 1.5, conf.int= TRUE,  legend.labs= c("Standard diet", "Rich diet", "Restricted diet"), 
	xlab = "Adult age (days)", pval = TRUE)

                        


