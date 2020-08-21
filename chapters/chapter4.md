---
title: 'Chapter 4: Survival analysis'
description:
  'Analysis of survival curves'
prev: /chapter3
next: /chapter5
type: chapter
id: 4
---

<exercise id="1" title="What is Survival analysis">

**Survival analysis deals with so called time to event data**: it's a branch of statistics that models the time until an event or events of interest occur. The event of interest can be death, but it can also be failure, for example, or age at first reproduction. In biology, we are often interested in comparing the effects of experimental treatments on survival curves. Survival curves describe the age-dependent probabilities of surviving in time-intervals, ideally of the same duration, that are small enough to give a meaningful resolution. 

For example, this can be years for survival in human populations, or days in shorter lived populations of insects. Survival analyses does not have to start at birth. The starting point could be the start of a treatment or the age at which a certain disease has been diagnosed. Here, we will be analysing lifespan data from birth (or eclosion into adulthood in our fly example) to death. In contrast to the analysis of mean or median lifespan, survival analysis is equipped to handle deaths that are not observed. This means that individuals that start in an experimental cohort and might escape or be killed due to a methodological mistake can still be used in the analysis. These un-observed deaths are *censored* at the time-point / age when they have been last recorded as alive. **Important**: the censored deaths have to be *non-informative*.

**How does this work?** Survival probabilities are calculated by dividing the number of survivors of a time interval by the number of live individuals that entered that time interval. For illustration, let's think about an experiment where half of the individuals escape, but this happens gradually when they had already reached older ages (yes, I agree, you would have to repeat the whole experiment, because something obviously went very wrong, but bear with me for the sake of this exercise). If you would exclude all these individuals completely, because you have no way of telling how long they would have lived, you would not only throw out data, but you would also underestimate survival at younger ages for your experimental cohort! This is because survival probability (S) at a time interval at young age in which for example 3 individual died would have been 

**S(complete)** = [n(alive at start of interval) - 3] / n(alive at start of interval)    
if all those other individuals wouldn't have escaped later on.

**S(excluded)** = [n(alive at start of interval) - n(escaped) - 3] / [n(alive at start of interval) - n(escaped)]    
if the escaped individuals get completely excluded.

Setting e.g. <u>n(alive at start of interval) = 50</u> and <u>n(escaped) = 30</u> then gives

**S(complete)** = 47/50 = 0.94

**S(excluded)** = (50-30-3) / (50-30) = 0.85

With censoring, individuals whose deaths are censored stay in the analysis until the time interval in which the censored deaths occurs, letting us to use all available data and providing S(complete).

Collections of age-dependent variables such as survival rate, mortality rate, hazard rate etc. can be presented as **life tables** which can be calculated in various R packages. It gets a little confusing though, as most packages for this job have different requirements. I recommend package BaSTA, using function [*MakeLifeTable*](https://rdrr.io/cran/BaSTA/man/MakeLifeTable.html), with e.g. ```MakeLifeTable(data$lifespan, ax = 0.5, n = 1)```. You can also do your own custom version in R, building on the survival values (*lx*) in package *survival*, for example like this:

```group1_4$status <- 1
library(survival)
library(dplyr)

# You need a censoring/status variable/column. 
# If you have no censoring/status column yet, and all deaths were observed (=1):
data1$status <- 1

surv1 <- survfit(Surv(lifespan, status)~ 1, data= data1)
surv1.summary <- summary(surv1)

# Extract values from the survfit summary and
# calculate new values. Function 'lead()' from dplyr is very neat, as it takes the value # of the next row of 'Alive', instead of the same row value.

lifetable.surv1 <- as.data.frame(surv1.summary[c(2:6)]) %>%
  select(Age = time, Alive = n.risk, lx = surv) %>% 
  mutate(qx = (Alive - lead(Alive)) / Alive, mux = -log(1-qx))
  
plot(lifetable.surv1$Age, lifetable.surv1$mux)

# For nicer tables in markdown, you can use package 'kableExtra'
# library(kableExtra)
# kable(lifetable.surv1, format= "markdown", align= "c")
```

![](https://github.com/zajitschek/lifespananalysis/blob/master/images/pushpin.svg?raw=true) Take a careful look at the duration of age intervals for which live table rates might be provided. There might be recorded deaths for every time unit (for example 1 day for shorter-lived species, or 1 year for longer-lived species). You'll notice that in the code above, rates for age ranges without any deaths are not listed, as they were not explicitly included in the original survival data. However: If no deaths occur in a given age-interval, that's data, too! This will often become more of an issue at older ages. Also, keep in mind that calculation of rates often does not take into account whether the underlying number of  deaths is very small (e.g. under 5) or large enough: in other words, it gives all calculated values equal weight, which might not be very desirable when analysing the data further, or when comparing mortality rates between populations.



We will now have  a look at **Kaplan-Meier survival curve plots, logrank tests and Cox Proportional hazards** - probably the types of models that you'll have come across already if you have read some papers on biological research that analyses lifespan.



</exercise>

<exercise id="2" title="Kaplan-Meier (KM) estimates">

# Simple and robust: KM plots and log-rank tests

The typical survival plots are also called Kaplan-Meier curves. They display cumulative survival probabilities, and look like steps down from left to right, or are smoothed curves of the step-version. 

Log-rank tests can be used to test whether two survival curves differ. This is the simplest test, with the draw back that it can only handle two curves, but with the advantage (like the KM plots) that there are no assumptions on underlying distributions (i.e. KM and log-rank tests are *non-parametric*) and that censored deaths can be included in the analysis. 

Plot two survival curves and try to tell which group they belong to (use the code hint).

<codeblock id="9">

Have a look in the code above to calculate life tables, especially the function after creating the *survfit* object.

</codeblock>

Nice, but a little underwhelming. Fortunately, there are some packages that can help to produce nicer plots containing more information. Let's see how to do this with package *survminer*.

<codeblock id="10">

No hint.

</codeblock>

We added a legend, 95% confidence limits, and made the lines thicker and changed the x-axis label.

Next, we would like to test whether these two survival curves are different. 

<codeblock id="11">

No hint.

</codeblock>

Easy. The p-value from the logrank-test is very small, as expected from the diverging curves and the non-overlapping confidence limits. 

**Sometimes this is all it takes.** If you have more complex study designs, with more treatments and more explanatory variables (as we have, for example, in our sample lifespan data: not only 1 cage diet and 2 assay diets, but 3 levels for each treatment), we will have to use other models, such as the **Cox proportional hazard model.**

</exercise>



<exercise id="3" title="Cox proportional hazards (Cox PH)">

# Cox proportional hazard (Cox PH) models

In ecology and evolution studies, we regularly want to test the effects of more variables on survival in more than two experimental groups. Cox PH models (also called *Cox regression* models) allow us to test complex multivariate effects. These models are implemented in the package *survival* as well. There is also a mixed model package *coxme* and Bayesian models, for example in *rstanarm* (see next section).

<codeblock id="12">
</codeblock>

We see that assay diet has a significant effect on survival curves. In the *summary* output of the coxph() model, two levels of assay diet (3 and 4) are tested against the reference level (1). The reference level is chosen automatically, as the first level out of the factor *assaydiet*, ordered in ascending order internally by R. To test whether *assaydiet* had an effect, we ran another model *without assaydiet* that just contained an intercept (coded as ~1), and compared the model containing assaydiet with the model without assaydiet, using the anova() function.

Tests for the proportionality of hazards were **not significant**, and therefore showed that we can assume that hazards are proportional. WE also see this in the diagnostic graphics of the *Schoenfeld residuals*: there is no non-random pattern of the residuals against time.

Next, we will have a look at **mixed effects Cox PH models** with function ***coxph* (package *survival*)** and  function **coxme (package *coxme*)**. These are probably the models you would be using, if you want to adjust for intra-group correlations, by adding one or more random effects (such as 'container', 'cage', 'population', for example). 

*Note*: while we are only using categorical fixed effects, it is possible to use continuous variables as well (also for cox.ph()).

<codeblock id="13">
</codeblock>

As you can see, the coefficients of all four models are quite similar in this case. Hazards for flies on assay diet 3 (high protein diet) is positive (0.86) and therefore higher than flies on assay diet 1 (standard diet): they die earlier overall. In contrast, flies on assay diet 4 (restricted diet) show a negative coefficient (-0.38) and therefore die overall later than flies on assay diet 1.

Even the simplest Cox PH model without clustering or any sort of random grouping gives similar answers. We can see why: variable *cage* does not explain much of the variation, with a variance in hazards explained by the fact that flies that are in the same cage have more correlated hazards of only 0.0188.

</exercise>

<exercise id="4" title="Survival analysis as a Bayesian">

# rstanarm::stan_surv

We will run some survival models in the package *rstanarm*. You will see that they are more flexible than frequentist survival models that we have seen in the last section (e.g. Cox PH models in packages *survival* or *coxme*).

If you want to do this exercise, you will have to open RStudio in your webbrowser (by clicking  [![Binder](https://mybinder.org/badge_logo.svg)]( https://mybinder.org/v2/gh/zajitschek/RStudioLifespanBayesian/master?urlpath=rstudio )). It's the same RStudio image / environment that we used in the previous chapter for *rstanarm*. If you have it still open, there is no need to reopen it again. 

This image of RStudio will have package *rstanarm* installed, and the fly lifespan data we used before will be available to load.

You will have to load the provided script named 'rstanarm_surv.R'.

In RStudio, go to *File -> Open File*, then choose the file 'rstanarm_surv.Rmd', located in the folder 'R', click open, and follow the steps outlined in the R script that opens up ('rstanarm_surv.R').



</exercise>

