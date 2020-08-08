###CODEBLOCK 13###

# Load package and data
library(bbmle)
data1 <- read.csv("expevol_male_flies.csv")

# Select group (here: standard cagediet & restricted assaydiet)
group1_4 <- subset(data1, cagediet==1 & assaydiet==4)

# Attach the data (careful: in a large script, this isn't recommended, 
#as it's easy to forget to detach data again)
attach(group1_4)

### Define Gompertz function ###

ll <- function (a,b) {
  -sum(log(a*exp(b*lifespan-a*(exp(b*lifespan)-1)/b)))
}

# Give the starting value guesses for the maximum likelihood maximization procedure
#that function mle2 uses

guess <- list(a=0.0001,b=0.05)
fit.Gompertz <- mle2(ll, start= guess, method= "Nelder-Mead")
fit.Gompertz
summary(fit.Gompertz)
confint(fit.Gompertz)

### Define Gompertz-Makeham function ###

ll <- function (a,b,c) {
  -sum(log((c+a*exp(b*lifespan))*exp((-a*(exp(b*lifespan)-1)/b)-c*lifespan)))
}
guess <- list(a=0.0001,b=0.05,c=0.01)
fit.GompertzMakeham <- mle2(ll, start=guess, method="L-BFGS-B", 
                            lower = c(1e-8,1e-8,1e-8), upper = c(0.2,0.2,0.4), 
                            control=list(ndeps=c(0.00000001,0.000001,0.000001),
                                         parscale=c(1/0.01,1/0.01,1/0.01),
                                         maxit=3000,trace = FALSE))
fit.GompertzMakeham
summary(fit.GompertzMakeham)

