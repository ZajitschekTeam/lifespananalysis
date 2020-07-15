---
title: 'Chapter 3: Statistical tests of effects on lifespan'
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

We won't go into too much detail in explaining GLMM here, as you have vast amounts of online resources and excellent textbooks for this available). 

Simple linear regression models describe the relationship between values of a response variable and explanatory variables, with a constant change in explanatory variable resulting in a constant change in the response variable (= linear relationship), implying a normally distributed response variable. Generalized linear models (GLM) allow for different error distributions than the normal distribution and for different link functions (that's what we might want for lifespan data). Generalized linear mixed models (GLMM) further allow for the inclusion of random effects, which can be used to model grouping structures in our data that are often not the main focus of the analyses.

Here, we will focus on GLMM since they have become standard in recent years. 

## Mean lifespan and GLMM

Please be aware that this will only be a scratch on the surface. Together, we'll walk through the steps in setting up GLMM, running diagnostics (checking whether the assumptions of the model are violated), and interpreting and plotting results. There is an ever growing variety of available R packages for running GLMM. Here, I will use the most widely used GLMM package in R, called *lme4*, and I will give an example of how to perform the equivalent model in a Bayesian framework, using the R package *rstanarm*. 

If you are not interested in modelling mean lifespan (out of concerns that we mentioned previously), you can jump straight to the next Chapter, where I introduce a set of models that come under the umbrella term ***Survival analysis***.

</exercise>

<exercise id="2" title="lme4::glmer anyone?">

**GLMER**: "Generalized Linear Mixed Effects in R"

The notation "package name"::"function name" refers specifically to the function of the specified package in R and can be used in case there might be functions with identical names in a package that is loaded in your active R session.

Now, we are interested in testing whether individuals in different conditions, maybe experimental treatments, affect mean lifespan.

Let's use the lifespan values in the 'Aids2' data set we used previously. So far, we only calculated the overall mean and median, and we plotted the histogram of these data. We will first look at the data structure and its description again, to see which effects we can test (normally you would first have a sound hypothesis, design a study, collect the data, then run the types of analyses that you planned to run when designing the whole study).

<codeblock id="6">
No hints or solution necessary here.
</codeblock>

The first thing we see is that female density distributions of lifespan are very flat compared to distributions of males, except in state category "other". We also see that this is both due to longer tails on the right (more long lifespans in females compared to males) and on the left (more short lifespans  in females compared to males). There is an additional variable "T.categ" that describes the mode of transmission. Mothers can transmit the infection to their embryos, indicated as level "mother" for variable "T.categ". Might this be the reason for the long left distribution tails in female lifespan? This would mean that especially female babies are affected. We can have a look whether that is the case. We can then either exclude those cases, or we decide that we are actually interested in mode of transmission and the apparent interaction between "sex" and "T.categ" (= "sex" affecting the effect that "T.categ" has on lifespan). 

<codeblock id="7">
No hints or solution necessary here.
</codeblock>

</exercise>

<exercise id="3" title="Bayesian with rstanarm::stan_glmer">

Bayesian Statistics: 





</exercise>