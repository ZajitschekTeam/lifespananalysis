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

A exponential increase in hazard rate is used as a definition of ageing, and hazard rate models have therefore been used widely in this field. 

We will have a more detailed look at parametric hazard models of the Gompertz family: the Gompertz, the Gompertz-Makeham, the Logistic, and the Logistic-Makeham models. They are nested functions, i,e. the most complex one, the Logistic-Makeham, can be reduced to the simplest one, the Gompertz, by setting parameters to zero. (Another often used function to model aging is the Weibull function that is not part of the Gompertz function family and won't be discussed further here).

[pic of 4 functions]

These models are not based on any biological mechanism. The Gompertz function is named after the actuary Benjamin Gompertz who modelled age-specific human mortality rate to make better decisions about rates of regular payments and deposits, such as insurance or mortgage payments. He found that over most of the human lifespan, the age-specific mortality rate increases exponentially (Gompertz, 1825). Since his Gompertz function only has two parameters, one of them defining the rate of increase at higher values (= in late life), it has been used to directly test for (demographic or actuarial) aging in many studies.

The Gompertz function:



The Makeham parameters are just added constants, elevating the hazard rate across all ages for the same value (for both Gompertz and logistic).

A couple of decades ago, research started to find support for mortality rate to decrease again at very old ages (Vaupel). 

The logistic function was used to model this early exponential increase, followed by a levelling off at older ages:



This can be caused by heterogeneity in the study cohort (variation in individual frailty) or by a decrease in hazard for all individuals who reach a certain old age. Since the heterogeneity explanation gained more and more support, parametric mortality modelling of this kind we'll go through here has lost a lot of its appeal  for a number of researchers, but is still useful, in my opinion.

</exercise>

<exercise id="2" title="Fitting Gompertz family functions in R">

We will first use the package xyz to fit all 4 mortality functions to our fly data.

Then I will show how to write your own functions and fit them in the package *bbmle*

</exercise>

</exercise>

<exercise id="2" title="A short go at modelling interaction effects on Gompertz parameters">



</exercise>