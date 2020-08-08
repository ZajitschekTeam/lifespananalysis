###CODEBLOCK 15###

# Load package and data
suppressMessages(library(bbmle))
data1 <- read.csv("https://github.com/ZajitschekTeam/lifespananalysis/raw/master/binder/data/expevol_male_flies.csv")

## Convert mortality data to binomial setup

# Let's use columns vial, cagediet, assaydiet, idmix, lifespan
data1 <- data1[, c(1,4:7)]
names(data1)

## This is for a file with 5 columns: vial, cagediet, assaydiet, idmix, lifespan
## If you don't have the same number of parameters, change code below, 
## or just create a file with dummy parameter columns.

# Add id column (1 individual number per individual)
data1a <- data1 %>% select(id=vial, cagediet, assaydiet, idmix, lifespan) %>% mutate(id = row_number())
names(data1a)

# Create long data frame
data1.long <- as.data.frame(mapply(function (x) rep(x, data1a$lifespan), data1a[, 1:4]))

# Add survival column
data1.long$died <- unlist(sapply(data1a$lifespan, function (x) c(rep(0, x-1), 1)))

# Add column for sequential age per individual until its death (died==1)
data1.long %>% 
  group_by(id) %>% 
  mutate(age = row_number())

# Select group (here: standard cagediet & restricted assaydiet)
group1_4 <- subset(data1, cagediet== 1 & assaydiet== 4)

# Attach the data (careful: in a large script, this isn't recommended, 
# as it's easy to forget to detach data again)
attach(group1_4)

### BINOMIAL MORTALITY SETUP ###

### Define Gompertz function with binomial distribution ###

ll <- function (a,b) 
	-sum(dbinom(died,1,a*exp(b*age),log = TRUE))
guess <- list(a=0.01, b = 0.029)
fit.Gompertz <- mle2(ll, start=guess, method="Nelder-Mead")

# Note: you will get a warning message about NaNs (Not a number)
# but that is usually OK.  It is a consequence of the computer checking
# nonsense values

fit.Gompertz
confint(fit.Gompertz)

## If there's a convergence problem:
-set ndeps for each parameter smaller (default=0.001)
-use parscale (give a multplicator for each parameter so that parameters get scaled to 1 unit 
	(you can use '1/'parameter guess' as well)
     -set maxit higher, i.e increase number of iterations
     -with method="L-BFGS-B" you can narrow down the possible value range: make smaller to get convergence
     (value at which LL gets maximized has still to be in that parameter range you give of course!)
     -with method="L-BFGS-B" you'll hit the boundaries often. There's no error message, you have to check yourself!
       -use 'coef('model name') after method="L-BFGS-B"to get best fit parameters (e.g.: coef(fit.Gompertz) )
	:doesn't wotk very well, but worth a try
     
     use 'confint('model name') to estimate confidence intervals
     use summary('model name')' to get all estimates, standard errors, and -2 LL
     
     check Ben Bolker's materials on the web (his book, or search for 'mle2 +mdels +selection', or 'bbmle'))
