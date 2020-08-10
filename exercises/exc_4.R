###CODEBLOCK 4###

#Load packages
suppressMessages(library(rcompanion))
suppressMessages(library(dplyr))

# Load fly lifespan data, exctracted from the data set for Zajitschek et al 2016 Proc B
data1 <- read.csv("https://github.com/ZajitschekTeam/lifespananalysis/raw/master/binder/data/expevol_male_flies.csv")

# Have a look at its structure
str(data1)

data1 <- data1 %>% mutate_if(is.integer, as.factor)
          
# Calculate mean, median, CIs
groupwiseMean(lifespan ~ 1, data = data1, boot = TRUE, R = 1000, traditional = FALSE, bca = TRUE, percentile = TRUE)[,3:9]
median(data1$lifespan)
          
# Plot histogram and indicate mean and median values
hist(data1$lifespan, main = "Histogram of lifespan data")
       abline(v = mean(data1$lifespan), col = "blue", lwd = 2, )
       abline(v = median(data1$lifespan), col = "red", lwd = 2)
       text(52, 1285, label = 'Median', cex = 1.2)
       text(40, 1225, label = 'Mean', cex = 1.2)


                        


