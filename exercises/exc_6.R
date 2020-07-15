###CODEBLOCK 6###

#Load packages
library(ggplot)

# View built-in data sets
data(Aids2)

# View details about the 'Aids2' data
?Aids2

# For this exercise, we are only interested in the response variable 'age',
# and in the variables 'sex' and 'state'.
# Our main question is: Is there a sex difference in lifespan?

# ALWAYS plot the data before running models:
	-> get a feeling for the data and identify possible outliers / errors

theme_set(theme_classic())
          
# Plot
g <- ggplot(Aids2, aes(age))
g + geom_density(aes(fill=factor(sex)), alpha=0.8) + 
       facet_grid(state ~ 1) + 
       labs(title="Density plot", 
       subtitle="Lifespan grouped by sex and state",
       caption="Source: 'Aids2' data set",
       x="(Lifespan (age at death)",
       fill="State")






                        


