###CODEBLOCK 4###

#Load packages
suppressMessages(library(rcompanion))
suppressMessages(library(dplyr))

# Load fly lifespan data, exctracted from the data set for Zajitschek et al 2016 Proc B
data1 <- read.csv("expevol_male_flies.csv")

# Have a look at its structure
str(data1)

data1 <- data1 %>% mutate(across(where(is.integer), as.factor))
          
# Calculate mean, median, CIs
groupwiseMean(lifespan ~ 1, data = data1, boot = TRUE, R = 1000, traditional = FALSE, bca = TRUE, percentile = TRUE)
groupwiseMedian(lifespan ~ 1, data = data1, boot= T, bca = TRUE, percentile = TRUE)
          
# Plot histogram and indicate mean and median values
hist(data1$lifespan, main = "Histogram of lifespan data")
       abline(v = mean(data1$lifespan), col = "blue", lwd = 3.5, )
       abline(v = median(data1$lifespan), col = "red", lwd = 3.5)
       text(59, 1575, label = 'Mean', cex = 1.2)
       text(47, 1625, label = 'Median', cex = 1.2)


                        


