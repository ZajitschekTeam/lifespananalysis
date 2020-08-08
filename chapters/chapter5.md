---
title: 'Chapter 5: Parametric hazard models'
description:
  'Hazard models and aging'
prev: /chapter4
next: null
type: chapter
id: 5
---

<exercise id="1" title="What is the hazard rate and why analyse it?">

Hazard rate, mortality hazard, instantaneous rate of mortality all describe the same: the risk of dying in a certain time interval, independent of mortality rate in the previous time interval. 

![](https://github.com/zajitschekteam/lifespananalysis/blob/master/images/hazard_func.png?raw=true) 

with $p_{x} $ the probability of an individual that is alive at age *x* surviving to age *x* + 1.

A exponential increase in hazard rate is used as a definition of ageing, and hazard rate models have therefore been used widely in this field. 

We will have a more detailed look at parametric hazard models of the Gompertz family: the Gompertz, the Gompertz-Makeham, the Logistic, and the Logistic-Makeham models. They are nested functions, i,e. the most complex one, the Logistic-Makeham, can be reduced to the simplest one, the Gompertz, by setting parameters to zero. (Another often used function to model aging is the Weibull function that is not part of the Gompertz function family and won't be discussed further here).

These models are not based on any biological mechanism. The Gompertz function is named after the actuary Benjamin Gompertz who modelled age-specific human mortality rate to make better decisions about rates of regular payments and deposits, such as insurance or mortgage payments. He found that over most of the human lifespan, the age-specific mortality rate increases exponentially (Gompertz, 1825). The Gompertz function has two parameters: *a*, the baseline parameter, and *b*, the rate of increase at higher values (= in late life), with *a* > 0 and *b* > 0. **Parameter** ***b***, often called the ***aging parameter*** or the ***aging rate***, has been used to directly test for (demographic or actuarial) aging in many studies.

The Gompertz hazard function:

![](https://github.com/zajitschekteam/lifespananalysis/blob/master/images/Gomp_func.png?raw=true) 

How the Gompertz function looks like, plotted from age=0 to age=100:

![](https://github.com/zajitschekteam/lifespananalysis/blob/master/images/Gompertz.png?raw=true) 

You see that in **panel A**, the baseline parameter *a* is kept constant at a = 0.01. In **B.*, the ageing parameter *b* is kept constant at b = 0.02. Often, you'll see Gompertz curves plotted in their logarithmic form (the logarithm linearizes the exponential curves), as in **panels C and D**.

The Makeham parameters are added constants, elevating the hazard rate across all ages for the same value (for both Gompertz and logistic).

![](https://github.com/zajitschekteam/lifespananalysis/blob/master/images/Gomp_Make_func.png?raw=true) 

![](https://github.com/zajitschekteam/lifespananalysis/blob/master/images/Gomp_Make.png?raw=true) 

A couple of decades ago, research started to find support for mortality rate to decrease again at very old ages (Vaupel). 

The logistic function was used to model this early exponential increase, followed by a levelling off at older ages:

![](https://github.com/zajitschekteam/lifespananalysis/blob/master/images/Logistic_func.png?raw=true) 

![](https://github.com/zajitschekteam/lifespananalysis/blob/master/images/Logistic.png?raw=true) 

This can be caused by heterogeneity in the study cohort (variation in individual frailty) or by a decrease in hazard for all individuals who reach a certain old age. Since the heterogeneity explanation gained more and more support, parametric mortality modelling of this kind we'll go through here has lost a lot of its appeal  for a number of researchers, but is still useful, in my opinion.

Last, this is how the Makeham extension of the Logistic function looks like:

![](https://github.com/zajitschekteam/lifespananalysis/blob/master/images/Logistic_Make_func.png?raw=true) 

![](https://github.com/zajitschekteam/lifespananalysis/blob/master/images/Logistic_Make.png?raw=true) 





</exercise>

<exercise id="2" title="Fitting Gompertz family functions in R">

Unfortunately, at the time of writing (mid 2020), there is no R package available to my knowledge that allows a very straightforward fitting of the four hazard models I introduced earlier. We will see that your best option will be to set up models in R package **BaSTA** that uses Bayesian techniques to estimate hazard rates and fit models, but there are also some other options.

- [package BaSTA](https://imada.sdu.dk/~colchero/basta/): "Survival Bayesian Trajectory Analysis". Handles more complex capture/mark/recapture data, but can also be used for less complex results from lab experiments.
- build your own models in R (we have a go at that below).
- run an old version of R package Survomatic (v1.4.0) on R 2.12.1 for Windows. For this, you need to install the proper R version from CRAN, and to download and install its dependencies (packages that are needed for Survomatic to function) from a github repository I have created (explained below).
- get your hands on the software WinModest, developed by [Scott Pletcher](https://sites.google.com/a/umich.edu/pletcher-lab/), and run in in compatibility mode on Windows (works for Windows 10). You will have to contact Scott and ask him directly, as there are no direct download options to my knowledge. WinModest has been used extensively in the experimental aging literature.
- **not tested**: [package *flexsurv*](https://rdrr.io/cran/flexsurv/) fits Gompertz, Weibull and a few others out of the package, and can be set up for Gompertz-Makeham (using the eha package). Read how in the [vignette](https://cran.r-project.org/web/packages/flexsurv/vignettes/flexsurv.pdf).
-  **not tested**: [package *fmsb*](http://minato.sip21c.org/msb/man/GompertzMakeham.html) fits Gompertz-Makeham, but you have to provide the mortality rate *qx*



Before we move on to BaSTA, I will show how to write your own functions and fit them in the package *bbmle* (there are many ways you could potentially accomplish that in R).

I will explain two methods:

1) Probability density function setup

2) Hazard function setup



For the probability density function setup, look at this R script:

<codeblock id="14">
</codeblock>

This is how to set up the hazard function:

<codeblock id="15">
</codeblock>




If you want to install and use package Survomatic 1.4.0 (which was intended to serve as an R version of WinModest, but unfortunately discontinued; the current version 1.7.0 doesn't seem to work), follow these steps:

1. This works only on Windows

2. Go to: https://github.com/zajitschek/Survomatic1.4.0_for_R12.2.1

3. When you have R 12.2.1 installed on your local Windows computer, you need to download the provided .zip file that contains all necessary dependencies (see README.md, automatically shown on the first page when you go to https://github.com/zajitschek/Survomatic1.4.0_for_R12.2.1)

4. Get started with the following code (more in the provided manual, contained in the .zip file):

   ```R
   data <- read.csv(file.choose()) #load cohort data, with variable 'lifespan'
   model.fit <- findpars(data$lifespan,,summary = T)
   model.fit[5,4] #extract estimated parameter: here: logistic a
   model.fit[5,5] #extract estimated parameter: here: logistic b
   model.fit[5,7] #extract estimated parameter: here: logistic s
   ```

   

</exercise>

<exercise id="2" title="BaSTA">

We will run **BaSTA** in RStudio in your webbrowser (by clicking  [![Binder](https://mybinder.org/badge_logo.svg)]( https://mybinder.org/v2/gh/zajitschek/RStudioLifespanBayesian/BaSTA?urlpath=rstudio )). It's similar, but not the same RStudio image / environment that we used in the previous chapter for *rstanarm*. 

Once RStudio has been built and has opened in your browser, go to *File -> Open File*, then choose the file 'basta.R', located in the folder 'R', click open, and follow the steps outlined in the R script that opens up ('basta.R').

</exercise>

<exercise id="3" title="A short go at modelling interaction effects on Gompertz parameters">



</exercise>