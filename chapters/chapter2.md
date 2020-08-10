---
title: 'Chapter 2: Summary statistics for lifespan'
description:
  'Summary statistics and simulation'
prev: chapter1
next: chapter3
type: chapter
id: 2
---

<exercise id="1" title="Getting started: Descriptive statistics: Mean, median, maximum lifespan">

# Lifespan description 

This is the situation: you have a data set of 40 adult animals. You know when they were born, and when they died. Only very few individuals died at young age. Somebody asks you: "So, how long did they live?"

Your answer could be: "They lived on average for *x* days, their median lifespan was *y* days, and their maximum lifespan was *z* days."

Ok. Let's create data in R and calculate these summary statistics.

<codeblock id="2">
Check out what happens when you change some of the values and re-run the script / code.
</codeblock>


## Mean, median, maximum lifespan

The arithmetic mean, also often just called the *mean*, is probably the first summary statistic of a set of values that comes into mind (careful: sometimes, the *average* refers not to the mean, but to the median, e.g. in *the average household income*). Both *mean* and *median* are measures that describe a *central tendency* - a center of a distribution. The problem is that not all data are normally distributed: normally distributed data have identical mean and median, and are symmetric around the mean / median. But as we saw with the made-up data in the previous example, this doesn't have to be the case. It turns out that lifespan data are indeed very often not normally distributed, but rather left skewed (with more occurrences of higher values). In addition, outliers can strongly affect the mean, not so much the median, which becomes very problematic with small sample sizes (few available lifespan values that are used to calculate the mean).

Why bother with the mean at all then? In statistical testing, which we'll come to soon, we often assume underlying distributions that allow us to estimate variances / spread around the mean to be able to perform powerful statistical tests (parametric tests, such as regression, ANOVA, linear models, etc.). Non-parametric tests in general do not assume any distributional properties (such as tests comparing medians), have less power and are not as flexible to incorporate multiple covariates (such as body size or genotype of an individual).

In the previous R code, we calculated maximum lifespan as the maximum lifespan of any individual in the study population. Vey often in the scientific literature, the arithmetic mean of the upper / top 10% of lifespan values are defined as the 'maximum lifespan'. This could be calculated with

```
library(dplyr)
lifespan_data %>% as.data.frame() %>%
  summarise(meanTop10percent = mean(.[.<= quantile(., 0.9)] ))
```
This definition of maximum lifespan seems more relevant in samples that just have one or very few (compared to the overall sample size) very old individuals. If in doubt, report both.

![](https://github.com/zajitschek/lifespananalysis/blob/master/images/pushpin.svg?raw=true) ***Note***   
In order to be transparent in your analyses, it is good practice to report means and medians, maybe in addition with histograms, to show the reader the nature of the analysed data. State exactly what statistic is reported, even better, report the code / script that you used, for others to be able to reproduce your results.

The measure of central tendency, like the mean, is important. But we also have to report the spread around the mean: how long are the tails of the distribution of lifespan values around the mean?

Check out this [interactive web app](https://shiny.abdn.ac.uk/Stats/apps/app_normal/) (create in R, as a shiny app, by the way) . On the left side, tick the box "**Check the box to update instantly**", increase sample size (**Sample: Number of observations**) to > 1000, and change **Plot type** to **Overlay Normal Density**. Now you can change the variation / spread around the mean by changing the standard deviation (**True Population Standard Deviation: σ**). See what happens to the tails of the displayed distribution.

![](https://github.com/zajitschek/lifespananalysis/blob/master/images/pushpin.svg?raw=true) 
Whenever you report mean or median, a measure of variation around these statistics have to be reported as well. This is most often either the standard deviation, the standard error, or the 95% confidence intervals (CI). The next R codeblock shows how to calculate 95% CI for mean and median values.

<codeblock id="3">
Type in the code from above to load lifespan data, and to calculate mean and median lifespan, and the their corresponding 95% confidence intervals.
</codeblock>

For the median, it's normally sufficient to report point estimates (without confidence intervals). But  have a look at the help file of *groupwiseMedian* (execute *?groupwiseMedian*) to read more about the available options.

Let's try this with another data set. R and its packages come with provided data sets. You can see the available data sets in your session (given the packages you loaded) with the command:

<code>data()</code>

We are interested in lifespan / survival data from an experimental study. Since I can't really find a good data set in the R data sets, we'll use data from my own previous research that I published here: [Zajitschek et al. ProcB 2016 (paper)](https://doi.org/10.1098/rspb.2015.2726).

We load the data set to do the calculations and plots we did previously on our self-created data. For now, let's ignore the fact lifespan data are from flies from different treatment groups and let's average across all individuals' lifespan values.

<codeblock id="4">
The function doesn't seem to work for the "bca" calculations. Set bca to "FALSE" and try again.
</codeblock>

</exercise>

<exercise id="2" title="Lifespan distributions and how to simulate data">

# Simulate lifespan data 

Age-dependent survival - when and how many individuals of a cohort die - can be described by a variety of different distributions. Let's have a look at the Figure from [Colchero et al. (PNAS, 2016)](https://doi.org/10.1073/pnas.1612191113) again:



![](https://github.com/zajitschek/lifespananalysis/blob/master/images/ColcheroPNAS2016.png?raw=true) 
We see smoothed lifespan distributions for females (red) and males (blue) for several primate species, with lifespan distributions of different human populations in the two bottom rows. Solid vertical lines show life expectancies, calculated as mean lifespans. Infant mortality (before age 1 y) is reported in *Inset* pie charts. Only in the data from modern Sweden (2000-2009) and Japan (2012), infant mortality is very low. High frequencies of death at early and and late ages can be modelled with specific distributions (e.g. bathtub curved distributions). Whether infant or young age mortality is pronounced depends very much on the studied species and on the circumstances in which lifespan was measured. For fruit flies, for example, young age adult mortality is not very important. Here, we will go through some steps to simulate data that are quite similar to the Swedish and Japanese lifespan data above.

These simulations should give you a better feeling of the nature of lifespan data. We will see that it might not be necessary to fit models to your lifespan data that require any knowledge of distributions that might provide a good fit to the data (see non-parametric models in Chapter 4). However, if we decide to use linear models, we will have to make sure that the conditional distributions of lifespan data is normally distributed. This can often be achieved not only by choosing appropriate explanatory variables, but also by employing *generalized* (in contrast to *general*) linear models that allow to model response variables from different distributions. We will also have a peak at parametric models of instantaneous mortality rate (hazard rate) in Chapter 5. These models are popular in descriptions of the ageing process. Again, I believe that to be able to create / simulate data with certain properties yourself will be helpful to gain a deeper understanding of what you are doing in your analyses and might open up new ways of analysing your data.

<codeblock id="5">
Use a Chi-square distribution to simulate data. Set the sample size (number of values to be drawn) to 1000.
</codeblock>

This was a bit of an exercise to show what you can do in R. For lifespan-analysis using linear models, we will see in the next chapter that choice of error distributions is important.

As an overview for available distributions in R in general (not necessarily for modelling error in generalized linear models), have a look here:

https://cran.r-project.org/web/views/Distributions.html

