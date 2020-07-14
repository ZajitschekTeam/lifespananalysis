###CODEBLOCK 3###

#Load packages
library(rcompanion)
library(dplyr)

# View built-in data sets
data()

# View details about the 'Aids2' data
?Aids2

# Load 'Aids2' data set and have a look at its structure
data(Aids2)
str(Aids2)

# Calculate mean, median, CIs
groupwiseMean(age ~ 1, data = Aids2, boot = TRUE, R = 1000, traditional = FALSE, bca = FALSE, percentile = TRUE)
groupwiseMedian(age ~ 1, data = Aids2, bca = TRUE, percentile = TRUE, basic = TRUE)

# Plot histogram and indicate mean and median values
hist(Aids2$age, main = "Histogram of Aids2 lifespan data")
abline(v = mean(Aids2$age), col = "blue", lwd = 3.5, )
abline(v = median(Aids2$age), col = "red", lwd = 3.5)
text(33, 584, label = 'Mean', cex = 1.2)
text(43, 584, label = 'Median', cex = 1.2)


                        


