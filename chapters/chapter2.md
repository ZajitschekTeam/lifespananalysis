---
title: 'Chapter 2: Summary statistics for lifespan'
description:
  'Overview of useful summary statistics and how to calculate them.'
prev: chapter1
next: chapter3
type: chapter
id: 2
---

<exercise id="1" title="Getting started: Mean, median, maximum lifespan">

# Lifespan description 

This is the situation: you have a data set of 40 adult animals. You know when they were born, and when they died. Only very few individuals died at young age. Somebody asks you: "So, how long did they live?"

Your answer might be: "They lived on average for *x* days, their median lifespan was *y* days, and their maximum lifespan as *z* days."

Ok. Let's create data in R and calculate these values.

<codeblock id="2">
Check out what happens when you change some of the values and re-run the script / code.
</codeblock>


## Mean and median

The arithmetic mean, also often just called the *mean*, is probably the first summary statistic of a set of values that comes into mind (careful: sometimes, the *average* refers not to the mean, but to the median, e.g. in *the average household income*). Both *mean* and *median* are measures that describe a *central tendency* - a center of a distribution. The problem is that not all data are normally distributed: normally distributed data have identical mean and median, and are symmetric around the mean / median. But as we saw with the made-up data in the previous example, this doesn't have to be the case. It turns out that lifespan data are indeed very often not normally distributed, but rather left skewed (with more occurrences of higher values). In addition, outliers can strongly affect the mean, not so much the median, which becomes very problematic with small sample sizes (few available lifespan values that are used to calculate the mean).

Why bother with the mean at all then? In statistical testing, which we'll come to soon, we often assume underlying distributions that allow us to estimate variances / spread around the mean to be able to perform powerful statistical tests (parametric tests, such as regression, ANOVA, linear models, etc.). Non-parametric tests in general do not assume any distributional properties (such as tests comparing medians), have less power and are not as flexible to incorporate multiple covariates (such as body size or genotype of an individual).

![](https://github.com/ZajitschekTeam/lifespananalysis/blob/master/images/pushpin.svg?raw=true) ***Note***   
In order to be transparent in your analyses, it is good practice to report means and medians, maybe in addition with histograms, to show the reader the nature of the analysed data. State exactly what statistic is reported, even better, report the code / script that you used, for others to be able to reproduce your results.

The measure of central tendency, like the mean, is important. But we also have to report the spread around the mean: how long are the tails of the distribution of lifespan values around the mean?

Check out this [interactive web app](https://shiny.abdn.ac.uk/Stats/apps/app_normal/) (create in R, as a shiny app, by the way) . On the left side, tick the box "**Check the box to update instantly**", increase sample size (**Sample: Number of observations**) to > 1000, and change **Plot type** to **Overlay Normal Density**. Now you can change the variation / spread around the mean by changing the standard deviation (**True Population Standard Deviation: σ**). See what happens to the tails of the displayed distribution.

![](https://github.com/ZajitschekTeam/lifespananalysis/blob/master/images/pushpin.svg?raw=true) 
Whenever you report mean or median, a measure of variation around these statistics have to be reported as well. This is most often either the standard deviation, the standard error, or the 95% confidence intervals (CI). The next R codeblock shows how to calculate 95% CI for mean and median values.

<codeblock id="3">
Type in the code from above to load lifespan data, and to calculate mean and median lifespan, and the their corresponding 95% confidence intervals.
</codeblock>

Let's try this with another data set. Conveniently, R and its packages come with provided data sets. You can see the available data sets in your session (given the packages you loaded) with the command:

<code>data()</code>

We are interested in lifespan / survival data. To see details of the data set 'Aids2' in the package 'MASS', type and execute

<code>?Aids2</code>

Sounds good. To use those data, we load the data set to do the calculations and plots we did previously on our self-created data.

<codeblock id="4">
</codeblock>



</exercise>