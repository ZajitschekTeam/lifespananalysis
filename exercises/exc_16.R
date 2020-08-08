###CODEBLOCK 16###

#Load packages and data
suppressMessages(library(BaSTA))
#library(parallel)
#library(snowfall)
#script for function 'plotFancyBaSTA' is at bottom of this script file

data1 <- read.csv("https://github.com/ZajitschekTeam/lifespananalysis/raw/master/binder/data/expevol_male_flies.csv")
data1 <- data1 %>% mutate(across(where(is.integer), as.factor))
data1$status <- 1

# Create a subset of three treatment groups/cohorts 
# (3 assay diets (= all that are available) from 1 cagediet)
group1 <- subset(data1, cagediet== 1)
          
# Run a Cox Proportional Hazards model (CoxPH)

## Setup data for BaSTA ##


## V_ADLD ##
#fuer basta: use AD subsets, i.e. only 3 levels of ED
basta_v2 <- matrix(0, nrow = nrow(group1), ncol = max(group1$age))
basta_v2 <- as.data.frame(basta_v2)
vbasta3 <- cbind(V_ADLD[,c(1,2,8)], basta_v2)
names(vbasta3) <- c("AD", "ED", "age", seq(1, max(V_ADLD$age)) )
vbasta3$age <- vbasta3$age -1
str(vbasta3)
idx <- do.call(rbind, Map(function(a,b) 
    cbind(a, match(1:b, colnames(vbasta3))), 
    seq_along(vbasta3$age), vbasta3$age))
vbasta3[idx]<-1
head(vbasta3)
##below: split ED into 3 separate columns, containing 0 and 1
basta_v <- cbind(seq(1,nrow(vbasta3)), rep(1, nrow(vbasta3)), vbasta3$age+1,  vbasta3[,4:(max(V_surv$age)+3)], vbasta3$ED,vbasta3$ED,vbasta3$ED)
basta_v$"1" <- rep(0, nrow(vbasta3))
str(basta_v)
names(basta_v) <- c("ID", "BIRTH", "DEATH", seq(1, max(V_surv$age)), "ED_LD", "ED_SD", "ED_HD")
str(basta_v)
head(basta_v)
##recode LD,SD,HD into 0 and 1
basta_v2 <- basta_v
basta_v2$ED_LD <- as.character(basta_v2$ED_LD); basta_v2$ED_SD <- as.character(basta_v2$ED_SD); basta_v2$ED_HD <- as.character(basta_v2$ED_HD)
basta_v2$ED_LD[basta_v2$ED_LD == "LD"] = 1
basta_v2$ED_LD[basta_v2$ED_LD != "1"] = 0
basta_v2$ED_SD[basta_v2$ED_SD == "SD"] = 1
basta_v2$ED_SD[basta_v2$ED_SD != "1"] = 0
basta_v2$ED_HD[basta_v2$ED_HD == "HD"] = 1
basta_v2$ED_HD[basta_v2$ED_HD != "1"] = 0
basta_v2$ED_LD <- as.numeric(basta_v2$ED_LD); basta_v2$ED_SD <- as.numeric(basta_v2$ED_SD); basta_v2$ED_HD <- as.numeric(basta_v2$ED_HD)
str(basta_v2)
head(basta_v2)
basta_ADLD <- basta_v2

## V_ADSD ##
#fuer basta: use AD subsets, i.e. only 3 levels of ED
basta_v2 <- matrix(0, nrow = nrow(V_ADSD), ncol = max(V_ADSD$age))
basta_v2 <- as.data.frame(basta_v2)
vbasta3 <- cbind(V_ADSD[,c(1,2,8)], basta_v2)
names(vbasta3) <- c("AD", "ED", "age", seq(1, max(V_ADSD$age)) )
vbasta3$age <- vbasta3$age -1
str(vbasta3)
idx <- do.call(rbind, Map(function(a,b) 
    cbind(a, match(1:b, colnames(vbasta3))), 
    seq_along(vbasta3$age), vbasta3$age))
vbasta3[idx]<-1
head(vbasta3)
##below: split ED into 3 separate columns, containing 0 and 1
basta_v <- cbind(seq(1,nrow(vbasta3)), rep(1, nrow(vbasta3)), vbasta3$age+1,  vbasta3[,4:(max(V_surv$age)+3)], vbasta3$ED,vbasta3$ED,vbasta3$ED)
basta_v$"1" <- rep(0, nrow(vbasta3))
str(basta_v)
names(basta_v) <- c("ID", "BIRTH", "DEATH", seq(1, max(V_surv$age)), "ED_LD", "ED_SD", "ED_HD")
str(basta_v)
head(basta_v)
##recode LD,SD,HD into 0 and 1
basta_v2 <- basta_v
basta_v2$ED_LD <- as.character(basta_v2$ED_LD); basta_v2$ED_SD <- as.character(basta_v2$ED_SD); basta_v2$ED_HD <- as.character(basta_v2$ED_HD)
basta_v2$ED_LD[basta_v2$ED_LD == "LD"] = 1
basta_v2$ED_LD[basta_v2$ED_LD != "1"] = 0
basta_v2$ED_SD[basta_v2$ED_SD == "SD"] = 1
basta_v2$ED_SD[basta_v2$ED_SD != "1"] = 0
basta_v2$ED_HD[basta_v2$ED_HD == "HD"] = 1
basta_v2$ED_HD[basta_v2$ED_HD != "1"] = 0
basta_v2$ED_LD <- as.numeric(basta_v2$ED_LD); basta_v2$ED_SD <- as.numeric(basta_v2$ED_SD); basta_v2$ED_HD <- as.numeric(basta_v2$ED_HD)
str(basta_v2)
head(basta_v2)
basta_ADSD <- basta_v2

## V_ADHD ##
#fuer basta: use AD subsets, i.e. only 3 levels of ED
basta_v2 <- matrix(0, nrow = nrow(V_ADHD), ncol = max(V_ADHD$age))
basta_v2 <- as.data.frame(basta_v2)
vbasta3 <- cbind(V_ADHD[,c(1,2,8)], basta_v2)
names(vbasta3) <- c("AD", "ED", "age", seq(1, max(V_ADHD$age)) )
vbasta3$age <- vbasta3$age -1
str(vbasta3)
idx <- do.call(rbind, Map(function(a,b) 
    cbind(a, match(1:b, colnames(vbasta3))), 
    seq_along(vbasta3$age), vbasta3$age))
vbasta3[idx]<-1
head(vbasta3)
##below: split ED into 3 separate columns, containing 0 and 1
basta_v <- cbind(seq(1,nrow(vbasta3)), rep(1, nrow(vbasta3)), vbasta3$age+1,  vbasta3[,4:(max(V_surv$age)+3)], vbasta3$ED,vbasta3$ED,vbasta3$ED)
basta_v$"1" <- rep(0, nrow(vbasta3))
str(basta_v)
names(basta_v) <- c("ID", "BIRTH", "DEATH", seq(1, max(V_surv$age)), "ED_LD", "ED_SD", "ED_HD")
str(basta_v)
head(basta_v)
##recode LD,SD,HD into 0 and 1
basta_v2 <- basta_v
basta_v2$ED_LD <- as.character(basta_v2$ED_LD); basta_v2$ED_SD <- as.character(basta_v2$ED_SD); basta_v2$ED_HD <- as.character(basta_v2$ED_HD)
basta_v2$ED_LD[basta_v2$ED_LD == "LD"] = 1
basta_v2$ED_LD[basta_v2$ED_LD != "1"] = 0
basta_v2$ED_SD[basta_v2$ED_SD == "SD"] = 1
basta_v2$ED_SD[basta_v2$ED_SD != "1"] = 0
basta_v2$ED_HD[basta_v2$ED_HD == "HD"] = 1
basta_v2$ED_HD[basta_v2$ED_HD != "1"] = 0
basta_v2$ED_LD <- as.numeric(basta_v2$ED_LD); basta_v2$ED_SD <- as.numeric(basta_v2$ED_SD); basta_v2$ED_HD <- as.numeric(basta_v2$ED_HD)
str(basta_v2)
head(basta_v2)
basta_ADHD <- basta_v2

#### BASTA RUNS ###

DataCheck(basta_ADHD, studyStart = 1, studyEnd = 86, silent=FALSE)

#out_basta_ADHDmulti <- multibasta(object= basta_ADHD, studyStart= 1, studyEnd= 86, niter=50000, burnin=5001, thinning=50,  
        models = c("EX", "GO", "LO"), shape = "simple", covarsStruct = "fused", nsim = 4, ncpus = 4, parallel = TRUE, updateJumps=TRUE)

out_basta_ADHD_exp <- basta(object= basta_ADHD, studyStart= 1, studyEnd= 86, niter=50000, burnin=5001, thinning=50,  
        model = "EX", shape = "simple", covarsStruct = "fused", nsim = 4, ncpus = 4, parallel = TRUE, updateJumps=TRUE)
out_basta_ADHD_exp$DIC[5] #15517.83
out_basta_ADHD$DIC[5] #13019.75
out_basta_ADHD_exp$DIC[5] - out_basta_ADHD$DIC[5] #2498.078 : Gompertz much better!

out_basta_ADHD <- basta(object= basta_ADHD, studyStart= 1, studyEnd= 86, niter=50000, burnin=5001, thinning=50,  
        model = "GO", shape = "simple", covarsStruct = "fused", nsim = 4, ncpus = 4, parallel = TRUE, updateJumps=TRUE)

#plot(out_basta_ADHD)
#plot(out_basta_ADHD, plot.trace = FALSE)
plotFancyBaSTA(out_basta_ADHD)
summary(out_basta_ADHD)