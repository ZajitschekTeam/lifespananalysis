---
title: 'Chapter 3: Inferential statistics I: Tests of effects on mean lifespan'
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

Now, we are interested in testing whether individuals in different conditions, such as experimental treatments, affect mean lifespan.

Let's analyse the lifespan values of male flies that evolved on 3 different diets, and were tested on 3 different diets, used previously. So far, we only calculated the overall mean and median, and we plotted the histogram of these data. We will first look at the data structure and at the other variables again, to see which effects we can test (normally you would first have a sound hypothesis, design a study, collect the data, then run the types of analyses that you planned to run when designing the whole study).

<codeblock id="6">
To run code that is commented out, delete the # in front of the code (in each line that you want to run).
</codeblock>

We have a good sample size and we see that about 40 male flies were kept in a single experimental vial, with 12 vials per diet treatment combination (cage diet x assay diet), and with 4 cages per diet (=cagediet) in which flies evolved for about 25 generations.

<codeblock id="7">
No hints or solution necessary here.
</codeblock>



<codeblock id="8">
No hints or solution necessary here.
</codeblock>

We see that assay diet is highly significant. We could proceed now and exclude the non-significant interaction term between assay diet and cage diet, run the model again, and then maybe remove the cage diet term if it is non-significant, and run a final model. This is a model selection strategy where non-significant terms are sequentially removed (starting with the most complex terms), until only significant terms are left in the final model. We could also stop here and report the model as is. This is not the place to discuss which model strategy to use, so I refer you to other sources of whether and how to do model selection.

</exercise>

<exercise id="3" title="Bayesian with rstanarm::stan_lmer">

Bayesian Statistics: 

Be aware that setting correct priors and setting up the correct model structure of more complicated Bayesian models can be very tricky. R packages such as MCMCglmm, and, more recently, brms and rstanarm, try to overcome this difficulty for simple models (i.e. reasonable default values are chosen automatically). Here is an example of a Bayesian GLMM in rstanarm. Caution: running this will take a couple of minutes!

<codeblock id="9">
No hints or solution necessary here.
</codeblock>



</exercise>