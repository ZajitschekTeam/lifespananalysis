###CODEBLOCK 11###

#Load packages and data
suppressMessages(library(dplyr))
suppressMessages(library(survival))
suppressMessages(library(survminer))
data1 <- read.csv("https://github.com/ZajitschekTeam/lifespananalysis/raw/master/binder/data/expevol_male_flies.csv")
data1 <- data1 %>% mutate(across(where(is.integer), as.factor))

# All deaths were observed. Add this information in a new column 'status':

data1$status <- 1

# Create a subset of two treatment groups/cohorts

group1_34 <- subset(data1, cagediet== 1 & (assaydiet== 3 | assaydiet== 4))
          
# Create a so-called 'survfit'-object

surv1 <- survfit(Surv(lifespan, status)~ 1, data= group1_4)

# Test whether the two curves differ

survdiff(Surv(lifespan, status)~ assaydiet, data= group1_34)

# Same result from the companion function in survminer 
# that can be used to do multiple pairwise tests 
# (with multiple testing correction of the p-value)

pairwise_survdiff(Surv(lifespan, status)~ assaydiet, data= group1_34)

# Include p-value in the survminer plot

ggsurvplot(surv1, size= 1.5, conf.int= TRUE,  legend.labs= c("Rich diet", "Restricted diet"), 
	xlab = "Adult age (days)", pval = TRUE)

                        


