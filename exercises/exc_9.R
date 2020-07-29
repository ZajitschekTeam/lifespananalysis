###CODEBLOCK 9###

#Load packages and data
suppressMessages((library(dplyr))
suppressMessages((library(survival))
data1 <- read.csv("expevol_male_flies.csv")
data1 <- data1 %>% mutate(across(where(is.integer), as.factor))
          
# 

                        


