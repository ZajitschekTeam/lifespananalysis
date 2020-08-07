###CODEBLOCK 13###

#Load packages and data
suppressMessages(library(dplyr))
suppressMessages(library(survival))
suppressMessages(library(survminer))
data1 <- read.csv("https://github.com/ZajitschekTeam/lifespananalysis/raw/master/binder/data/expevol_male_flies.csv")
data1 <- data1 %>% mutate(across(where(is.integer), as.factor))
data1$status <- 1

# Create a subset of three treatment groups/cohorts 
# (3 assay diets (= all that are available) from 1 cagediet)
group1 <- subset(data1, cagediet== 1)
          
# Run a Cox Proportional Hazards model (CoxPH)

surv_cph1 <- coxph(Surv(lifespan, status)~ assaydiet, data= group1)

summary(surv_cph1)

# Plot
surv1 <- survfit(Surv(lifespan, status)~ assaydiet, data= group1)
ggsurvplot(surv1, size= 1.5, conf.int= TRUE,  legend.labs= c("Standard diet", "Rich diet", "Restricted diet"), 
	xlab = "Adult age (days)", pval = TRUE)


# First fixed effect model
coxme1 <- coxme(Surv(lifespan, cens) ~ diet*sex + (1 | rep), data = dat2b) 
llcoxme1 = coxme1$logl[2]
coxme1

#Second model, w/o interaction
coxme2 <- coxme(Surv(lifespan, cens) ~ diet+sex + (1 | rep), data = dat2b) 

#Compare model fits
anova(coxme1, coxme2)

##CoxPH without random effect
coxph1 <- coxph(Surv(lifespan, cens) ~ diet*sex, data = dat2b)
llcoxph1 = coxph1$logl[2]
summary(coxph1)

cox.zph(coxph1) #testing proportional hazards assumption
?cox.zph

#LLR test 'by hand'
llcoxrqfull1; llq1; pchisq(abs(2*(llcoxrqfull1-llq1)), lower.tail=F, df=1) 
#use Integrated 

                        


