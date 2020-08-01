###CODEBLOCK 9###

#Load packages and data
suppressMessages((library(dplyr))
suppressMessages((library(survival))
data1 <- read.csv(".binder/data/expevol_male_flies.csv")
data1 <- data1 %>% mutate(across(where(is.integer), as.factor))

# All deaths were observed. Add this information in a new column 'status':

data1$status <- 1

# Create a subset of two treatment groups/cohorts

group1_34 <- subset(data1, cagediet== 1 & (assaydiet== 3 | assaydiet== 4))
          
# Create a so-called 'survfit'-object

surv1 <- survfit(Surv(lifespan, status)~ 1, data= group1_4)

# Plot the two survival curves
plot(surv1)

                        


