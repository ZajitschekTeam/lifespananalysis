---
title: 'Chapter 3: Inferential statistics on mean lifespan'
description:
  'Linear Models'
prev: chapter2
next: chapter4
type: chapter
id: 3
---

<exercise id="1" title="Jumping right into GLMM">

# Lifespan-analysis in generalized linear mixed models (GLMM)



## What are GLMM?

We won't go into too much detail in explaining GLMM here, as there are vast amounts of online resources and excellent textbooks that cover GLMM available. 

Simple linear regression models (LM) describe the relationship between values of a response variable and explanatory variables, with a constant change in explanatory variable resulting in a constant change in the response variable (= linear relationship), implying a normally distributed response variable. Generalized linear models (GLM) allow for different error distributions than the normal distribution and for different link functions (that's what we might want for lifespan data). Generalized linear mixed models (GLMM) further allow for the inclusion of random effects, which can be used to model grouping structures in our data that are often not the main focus of the analyses.

Here, we will focus on GLMM since they have become standard in recent years. 

## Mean lifespan and GLMM

Please be aware that this will only be a scratch on the surface. Together, we'll walk through the steps in setting up GLMM, running diagnostics (checking whether the assumptions of the model are violated), and interpreting and plotting results. There is an ever growing variety of available R packages for running GLMM. Here, I will use the most widely used GLMM package in R, called *lme4*, and I will give an example of how to perform the equivalent model in a Bayesian framework, using the R package *rstanarm*. 

If you are not interested in modelling mean lifespan (out of concerns that we mentioned previously), you can jump straight to the next Chapter, where I introduce a set of models that come under the umbrella term ***Survival analysis***.

</exercise>

<exercise id="2" title="lme4::glmer anyone?">

**GLMER**: "Generalized Linear Mixed Effects in R"

The notation "package name"::"function name" refers specifically to the function of the specified package in R and can be used in case there might be functions with identical names in a package that is loaded in your active R session.

Now, we are interested in testing whether individuals in different conditions, such as experimental treatments, affect mean lifespan.

Let's analyse the lifespan values of male flies that evolved on 3 different diets (called the 'cage diet' from here on), and were tested on 3 different diets, used previously. So far, we only calculated the overall mean and median, and we plotted the histogram of these data. We will first look at the data structure and at the other variables again, to see which effects we can test (normally you would first have a sound hypothesis, design a study, collect the data, then run the types of analyses that you planned to run when designing the whole study). We also use boxplots to check for outliers.

<codeblock id="6">
To run code that is commented out, delete the # in front of the code (in each line that you want to run).
</codeblock>

We have a good sample size (n = 4309) and we see that about 40 male flies were kept in a single experimental vial, with 12 vials per diet treatment combination (cage diet x assay diet), resulting in 12*40 = 480 flies per diet treatment, and with 4 cages per diet (= cagediet) in which flies evolved for about 25 generations.

Let's run a first model, restricting our data to flies that evolved on standard diet (cagediet 1) first!

<codeblock id="7">
No hints or solution necessary here.
</codeblock>

By loading package *lmerTest*, the anova() function spits out a classic ANOVA table (have a go and see what happens when you instead run the model with 'lme4::lmer(...)' and use the anova function, as in the script). 

This means we get p-values for every fixed effect (in our case, 'assaydiet'). It's the same for the 'summary()' command', only that we get p-values for the differences between the reference diet, shown under '(Intercept)' and set to 'assaydiet 1' automatically, since R ordered the levels of factor 'assaydiet' and treated the numbers, that are saved as characters, as numeric values for this purpose (if you want to reorder levels, search for function 'relevel'). If you would like to add the missing contrast between assaydiet 3 and assaydiet 4, you could use packages *multcomp* that implements corrections for multiple testing:

```R
library(multcomp)
summary(glht(lme4_glmm_model1, linfct = mcp(assaydiet = "Tukey")))
```

For diagnostic plots, you could use

```
plot(lme4_glmm_model1)
qqnorm(residuals(lme4_glmm_model1))

library(DHARMa)
sim_lme4_glmm_model1 <- simulateResiduals(fittedModel = lme4_glmm_model1)
plot(sim_lme4_glmm_model1)
```

We see that 'assaydiet' has a strong effect. Flies that were fed a restricted diet (assaydiet 4) lived on average longest, followed by flies on standard diet (assaydiet 1), and rich diet (assaydiet 3).

There are a variety of methods of how to plot the model-predicted mean lifespans. You could use

``` 
library(effects)
ef1 <- effect(lme4_glmm_model1)
plot(ef1)
```

or you could run
```print(confint(lme4_glmm_model1, method="boot"), digits=3)```

and extract the bootstrapped lower and upper 95% confidence limits (provided under '2.5 %' and '97.5 %'') to plot yourself (e.g. in with 'ggplot'), with the estimated means copied from the lmer summary output.

Let's have a quick look at what happens when we analyse all available data, including 'cagediet' (the diet that the previous ~ 25 generations of flies in 3 different treatments were fed).

<codeblock id="8">
No hints or solution necessary here.
</codeblock>

We see that assay diet is highly significant. We could proceed now and exclude the non-significant interaction term between assay diet and cage diet, run the model again, and then maybe remove the cage diet term if it is non-significant, and run a final model. This is a model selection strategy where non-significant terms are sequentially removed (starting with the most complex terms), until only significant terms are left in the final model. We could also stop here and report the model as is. This is not the place to discuss which model strategy to use, so I refer you to other sources of whether and how to do model selection.

</exercise>

<exercise id="3" title="Bayesian with rstanarm::stan_lmer">

**Bayesian Statistics**: Another branch of inferential statistics (we dealt with frequentist statistics so far) that has become accessible only in recent years, due the development of ever more powerful computers that take less time to perform computer-intensive sampling from probability distributions with MCMC (Markov chain Monte Carlo) methods. Bayesian statistics can implement and update knowledge about events that happen in your system of interest. This potential prior knowledge is reflected in the choice of *priors* (= the prior probability distribution). [Bayes theorem](https://en.wikipedia.org/wiki/Bayes'_theorem) is then used to calculate the posterior probability distributions, which are the conditional distributions of the uncertain quantities (e.g. effect sizes or parameters) given the data. 

Very often, uninformative priors are used (this is the case with 'out of the box solutions' such as the example in *rstanarm* below that works even when priors do not have to be defined in more detail by the user). The advantage of Bayesian statistics is that we get the whole posterior probability distribution of all parameters in a model, instead of point estimates of parameters in frequentist statistics. This means we can calculate credible intervals, instead of (frequentist) confidence intervals, with the very intuitive interpretation as a range of values to which a parameter is known to belong with an estimated probability. It also means that two non-overlapping credible intervals of the same parameter, estimated for different groups, can be interpreted as the parameters being different between groups. In frequentist statistics,  we need to calculate p-values and base our decision on whether effects are significant on a more or less arbitrary cut-off level (the *significance level*, often set at 0.05; see [here for a discussion and strong criticism of the use of p-values in scientific research](https://doi.org/10.1080/00031305.2019.1583913)).

**In Bayesian statistics we can say for a 95% Credible Interval**: "The value of interest (e.g. size of treatment effect / parameter) lies with a 95% probability in the interval."

**In frequentist statistics we can say for a 95% Confidence Interval**: "The **true** value of interest (e.g. size of treatment effect / parameter) will lie in the interval in 95% of the cases if the study would be repeated many times using samples from the same population."

![](https://github.com/zajitschek/lifespananalysis/blob/master/images/pushpin.svg?raw=true) Note: Often, credible intervals and confidence intervals are both abbreviated by CI.

Be aware that setting correct priors and setting up the correct model structure of more complicated Bayesian models can be very tricky. R packages such as *MCMCglmm*, and, more recently, *brms* and *rstanarm*, try to overcome this difficulty for simple models (i.e. reasonable default values, including priors, are chosen automatically). Here is an example of a Bayesian GLMM in *rstanarm* in an external image of RStudio (see below) that opens in your webbrowser. Why don't we run it here, in our convenient internal R images? Because the first time you open one of the R images in this course, all the packages that I specified have to be loaded. Loading package *rstanarm* would make this take even longer. 

**Caution:** running Bayesian models with any meaningful number of samples (such as given in the default settings) will take a couple of minutes!

# rstanarm::stan_lmer

We will run some survival models in the package *rstanarm*. You will see that they are more flexible than frequentist survival models that we have seen in the last section (e.g. Cox PH models in packages *survival* or *coxme*).

You will have to open RStudio in your webbrowser (by clicking  [![Binder](https://mybinder.org/badge_logo.svg)]( https://mybinder.org/v2/gh/zajitschek/RStudioLifespanBayesian/master?urlpath=rstudio )).

This image of RStudio will have package *rstanarm* installed, and the fly lifespan data we used before will be available to load.

You will have to load the provided script named 'rstanarm_lmer.R'.

In RStudio, go to *File -> Open File*, then choose the file 'rstanarm_lmer.R', located in the folder 'R', click open, and follow the steps outlined in the R script that opens up ('rstanarm_lmer.R').



</exercise>

