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

**Survival analysis deals with so called time to event data**: it's a branch of statistics that models the time until an event or events of interest occur. The event of interest can be death, but it can also be failure, for example. In biology, we are often interested to compare the effects of experimental treatments on survival curves. Survival curves describe the age-dependent probabilities of surviving in time-intervals, ideally of the same duration, that are small enough to give a meaningful resolution. 

For example, this can be years for survival in human populations, or days in shorter lived populations of insects. Survival analyses does not have to start at birth. The starting point could be the start of a treatment or the age at which a certain disease has been diagnosed. Here, we will be analysing lifespan data from birth (or eclosion into adulthood in our fly example) to death. In contrast to the analysis of mean or median lifespan, survival analysis is equipped to handle deaths that are not observed. This means that individuals that start in an experimental cohort and might escape or be killed due to a methodological mistake can still be used in the analysis. These un-observed deaths are censored at the time-point / age when they have been last recorded as alive. 

**How does this work?** Survival probabilities are calculated by dividing the number of survivors of a time interval by the number of live individuals that entered that time interval. For illustration, let's think about an experiment where half of the individuals escape, but this happens gradually when they had already older ages (yes, I agree, you would have to repeat the whole experiment, because something obviously went very wrong, but bear with me). If you would exclude all these individuals, because you have no way of telling how long they would have lived, you would not only throw out data, but you would also underestimate survival at younger ages for your experimental cohort! This is because survival probability (S) at a time interval at young age in which for example 3 individual died would have been 

**S(complete)** = [n(alive at start of interval) - 3] / n(alive at start of interval)    
if all those other individuals wouldn't have escaped later on.

**S(excluded)** = [n(alive at start of interval) - n(escaped) - 3] / [n(alive at start of interval) - n(escaped)]    
if the escaped individuals get completely excluded.

Setting e.g. <u>n(alive at start of interval) = 50</u> and <u>n(escaped) = 30</u> then gives

**S(complete)** = 47/50 = 0.94

**S(excluded)** = (50-30-3) / (50-30) = 0.85

With censoring, individuals whose deaths are censored stay in the analysis until the time interval in which the censored deaths occurs, letting us to use all available data and providing S(complete).

Collections of age-dependent variables such as survival rate, mortality rate, hazard rate etc. can be presented as **life tables** which can be calculated in various R packages, e.g. [package *demography*](https://rpubs.com/Timexpo/487053). 

We will have  a look now at **Kaplan-Meier survival curve plots, logrank tests and Cox Proportional hazards** - probably the types of models that you'll have come across already if you have read some papers on biological research that analyses lifespan.



</exercise>

<exercise id="2" title="Kaplan-Meier (KM) estimates">

# Simple and robust: KM plots and log-rank tests




<codeblock id="10">
</codeblock>

</exercise>



<exercise id="2" title="Cox proportional hazards (Cox PH)">

# Cox proportional hazard (Cox PH) models

Cox PH models allow us to test complex multivariate effects. These models are implemented in the package *survival* as well. There is also a mixed model package *coxme* and Bayesian models, for example in *rstanarm*.

<codeblock id="11">
</codeblock>



<codeblock id="12">
</codeblock>



</exercise>

<exercise id="3" title="Touching the Bayesian for completeness">

# stan_surv



<codeblock id="13">
</codeblock>



</exercise>

