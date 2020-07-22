###CODEBLOCK 5###

## Let's look at some distributions that might fit lifespan data well ##
# It's easier to do this with larger sample sizes #

# This sets the numerical seed for the following random sampling and makes the sample reproducible
set.seed(112)  

# How many values do we want to draw (=sample size)?
N <- ____ 

# Randomly draw N samples from a Chi-square distribution; test what happens when you change the 'df' value
lifespan_rchisq <- rchisq(N, df = 8)  #try also: rlnorm(N, meanlog = 0, sdlog = 1)

# Plot a histogram of the drawn sample of values; test what happens when you change the 'breaks' value
hist(lifespan_rchisq, breaks = 25, main = "Chi-square")

# Creat a mirror image of the distribution
hist(-lifespan_rchisq, breaks = 25, main = "Chi-square")

# We can get meaningful lifespan values by shifting the values to the right 
# Remember: we flipped the values first, mirroring on the axis x=0
hist(-lifespan_rchisq + max(lifespan_rchisq), breaks = 25, main = "Chi-square")

# If we want integers (whole numbers), we can round our values (very similar graph)
hist(round(-lifespan_rchisq + max(lifespan_rchisq)), breaks = 25, main = "Chi-square")