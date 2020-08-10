###CODEBLOCK 3###

#Load packages
suppressMessages(library(rcompanion))
suppressMessages(library(dplyr))

# Load previous lifespans
lifespan_data <- c(1,3,4,4,4,5,5,5,5,5,5,5,6,6,6,6,6,6,6,6,6,6,7,7,7,7,7,7,7,7,7,7,7,7,8,8,8,9,9,13)

# We will use two functions of the package library 'rcompanion' to calculate confidence intervals of the mean and median:
# 'groupwiseMean' and 'groupwiseMedian' 

# First, convert our vector of lifespan values into a data frame 
# See eg '?groupwiseMean' for a description of the function: 
# Under 'Arguments' you find data requirements, under 'Value' you find properties of the output

lifespan_data <- lifespan_data %>% as.data.frame() %>% rename(., lifespan = .) #we use pipes (%>%) from dplyr here

groupwiseMean(lifespan ~ 1, data = lifespan_data, boot = TRUE, R = 1000, traditional = FALSE, bca = TRUE, percentile = TRUE)[,3:9]

groupwiseMedian(lifespan ~ 1, data = lifespan_data, boot= TRUE, R = 1000, bca=F, exact=T)[,3:7]



                        


