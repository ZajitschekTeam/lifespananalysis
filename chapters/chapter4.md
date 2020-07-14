---
title: 'Chapter 4: Meta-analysis'
description:
  'The meta-analysis & quality checks'
prev: /chapter3
next: /chapter5
type: chapter
id: 4
---


<exercise id="1" title="Meta-analysis, evidence summary & assessment of certainty">

Once all the data are prepared, we can run our first meta-analytical model and assess the overall effect that we are interested in, across studies: the mean effect size, weighted by the precision of the observed effect sizes. We will assess the effect based on the model summary and, visually,  with forest plots. Since we probably have other variables that could potentially explain variation in our data, we will try to account and test some of these other variables in slightly more complex models. 

We are most interested in being able to make a statement on differences between treatment and control which are based on differences in biological response, and not on methodological or other technical differences between studies or study types, for example. We will go through some ways of assessing the influence of heterogeneity in our data, and whether we have any indication of publication bias in our data set.    


This is all best done hands-on:

# Worked Example

Using a subset of data (we decided to only go for fish) from a recent meta-analysis that investigated the relationship of dietary intervention on sperm traits across the animal kingdom (Macartney et al. 2019), we will go through the steps explained previously.

We are using the fish data that Erin had already collected - i.e. all relevant data have already been either extracted from the figures, or calculated from inferential statistics. This means we have a detailed datasheet available that contains a lot of information, but most importantly sample sizes, means and variances for control and treatment groups, for quite a range of different sperm traits. We have prepared this in such a way that we can use this to start from calculating effect sizes.


![](https://github.com/SusZaj/metaanalysis/blob/master/images/computertaskicon.svg?raw=true)  
We downloaded the two deposited data files from [osf.io](https://osf.io/aqw8u/) and created a file that we will use here ([click here](https://github.com/SusZaj/metaanalysis/blob/master/binder/data/Macartney2019_processed_fish.csv) to see / download the source .csv from github). Alternatively, run the code block - but that may look a little messy, due to the width of the data frame (the number of variables / columns and their length), especially if you are not used to investigating the data structure of files in R yet.

<codeblock id="fish_1">
Most of the variables will be self explanatory. Some aren't. We describe the ones that are important for our analysis below in more detail.
</codeblock>


| Variable name                          | Description                                        |
| -------------------------------------- | -------------------------------------------------- |
| *author* to *volume*                   | Publication information of specific studies        |
| *commonname_species* to *species_name* | Study organism identification                      |
| *trait_measured* and *trait_unit*      | Trait information                                  |
| *trait_category*                       | (see description below this table)                 |
| *mean_low* to *n_high*                | Descriptive statistics (extracted from literature) |
| *f* and *t*                | Inferential statistics (extracted from literature) |
| *es_method*                | Descriptive / inferential |
| *effectsize_id*              | Consecutive numbers for data manipulation (1 to 37)  |



***Trait category* description**

| ID number | Category                   |
| --------- | ------------------------------- |
| 1|    bodysize      |
| 2|    sperm length      |
| 3|    spermatophore/testis size      |
| 4|    sperm movement (velocity, % motile)      |
| 5|    sperm number      |
| 6|    sperm viability (alive vs dead, normal vs abnormal)      |

As said above, before we can analyse these data, we have to calculate the effect sizes. We will use the library *compute.es* to calculate SMD as *Cohen's d*. We have four different types of data to base our calculations on: 1) Descriptive statistics with SD, 2) Descriptive statistics with SE, 3) F-values (inferential statistic), and 4) t-values (inferential statistic). 

Different packages have different requirements in input variables and in syntax. *compute.es* requires SD and doesn't take SE. That's why we have to calculate SD from SE in one of the steps (you can find the simple formula in the code below - ). 
It also turns out that *compute.es* needs an id variable to do calculations for more than one provided value, which we provide (id= effectsize_id). You'll find yourselves in situations where something might not work immediately. Even the R package manual might not be able to help. Due to the huge R user base, you can often find solutions to very specific problems by googling them. Sometimes you have to find the solution yourself, by trying out possible versions. This was the case for us with the need to provide the id-argument in the following code (you can try what happens when you leave it out).

<codeblock id="fish_2b">
No hints or solution necessary here.
</codeblock>

You will notice that you will not get the complete data set printed here - that is because we haven't asked for it. You could look at the data by adding a last line: "str(fish.all)" or just call: "fish.all" and see what happens.

Notice also that we added a quick plot of the data and calculated the number of studies, traits per study organism, and also the mean / average of all effect sizes. So why can't we in theory stop here, with the overall mean effect size in hand, maybe calculate confidence intervals and that's it? 

<choice id="1">
<opt text="In theory, we could stop here, as any additional steps won't have a huge impact on the value of the mean."> 
That would be very easy, but would disregard all the other information we have on the data underlying the observed effect sizes. 
</opt>
<opt text="The whole point of a meta-analysis is to not only calculate the mean of the effect sizes, but to take precision of the underlying effect size estimates into account and produce a more meaningful weighted mean effect size." correct="true"> 
</opt>
</choice>

**Let's run a first model.** This is called a random effects model (in contrast to a fixed effects model, which is unlikely to be used by you and will therefore not be discussed here).

<codeblock id="fish_3">
No hints or solution necessary here.
</codeblock>

What does this output mean?

First, we get a few estimates related to heterogeneity (tau^2, ...). Heterogeneity in meta-analysis is important, but right now, this model does not account for potential effects due to different traits, species, and studies. This is why we will only look at the plot and discuss heterogeneity further down. 

We produced a forest plot. Nice, but before we go further: what about that value around 3? Whenever there seem to be outliers, always check. Indeed, we may have gotten some clue to double-check study 6 in the plot **Effect sizes within study** above. Sometimes it's biological, but very often outliers turn out as errors (e.g. through mistakes in data entry or data re-coding).

Let's look at this data point, labelled (wrongly so far) study 23 then:

<codeblock id="fish_4">
No hints or solution necessary here.
</codeblock>

This is the only study with a provided F-value test statistic. Since F values are the ratios of two variances, they have to be positive.
This means we wouldn't be able to see a negative effect size for this statistic. We have to go back and see what was exactly done in the original publication to add information to the F-value on whether it refers to an increase or a decrease in trait size (here: body mass).

In *compute.es* we added "low" diet values as first and "high" values as second data points. This means that the program calculated low - high, leading to negative values, at least in the case of body mass. Unsurprisingly, "high" diet leads to larger body size.
O'Dea found the same. This means, to have the same direction of effect as in the other studies that used means and SD/SE, we have to change sign in that study.
Before we do that, what about the other effect sizes that we calculated based on inferential test statistics?

<codeblock id="fish_5">
No hints or solution necessary here.
</codeblock>

*t*-values can be negative (they are the difference between treatment and control means, divided by SE). However, are the means ordered in the same way as are our other means to calculate the difference, i.e. mean(low treatment) - mean(high/control treatment)? We have to check in Evans 2017. They also found that high diets led to larger trait sizes than low diets, which means we have to change the sign of those effect sizes as well.

We can do this as follows:

<codeblock id="fish_6">
No hints or solution necessary here.
</codeblock>

Ok, great! The effect sizes are in the correct direction now.

Now, let's start again and re-run the first meta-analysis. Let's also correct the labels (using the *slab* argument in the *rma* function call.

<codeblock id="fish_7">
No hints or solution necessary here.
</codeblock>

We continue to ignore heterogeneity for now. The forest plot looks nice now. What we see is a grouping by study.

To see the results grouped by trait category, instead of grouped by study, we can re-order the data and print (here without saving the data in the other format)

<codeblock id="fish_8">
No hints or solution necessary here.
</codeblock>

This may be a more logical way to present our results. On top we see the traits related to body size, then sperm length, followed by sperm swimming speed, number, and viability. 

### Building a more meaningful model

Because of non-independence of data, we add random effects:
* between-study effects (<code>random = ~ 1 | study_id</code>), 
* within-study effects (<code>random = ~ 1 | effectsize_id</code>), and 
* phylogenetic effects; we use *genus* as a simpler substitute here (<code>random = ~ 1 | genus</code>)
  
    

![](https://github.com/SusZaj/metaanalysis/blob/master/images/pushpin.svg?raw=true)  If you are working with data from many taxa, you may want to add your phylogenetic tree here. 

<codeblock id="fish_9">
No hints or solution necessary here.
</codeblock>

Let's look at the results in more detail now. 

We have a table **Variance components** with the estimates of our random effects (*study_id*, *effectsize_id*, *genus*). We see that *genus* is no source of variation (estimate = 0.00). This means we could drop the term from the model. Variation within studies, due to measuring different traits, is more than 6 times larger than variation between studies.

The test for heterogeneity (Cochran’s Q-test: *Q* = 698.82, *df* = 36, *p* < 0.01) suggests substantial residual heterogeneity. Heterogeneity is the variability in our data, due to differences in experimental design, methods, data collection etc. We can look at heterogeneity using I^2, a measure that describes the amount of total variation explained by heterogeneity. For the multivariate *metafor* function *rma.mv*, there is unfortunately no I^2 summary output.
Luckily, *metafor* creator Wolfgang Viechtbauer provides the following function to calculate I^2:
<code>
I2 <- function(model){
    W <- solve(model$V) 
    X <- model.matrix(model)
    P <- W - W %*% X %*% solve(t(X) %*% W %*% X) %*% t(X) %*% W
    I2_total <- sum(model$sigma2) / (sum(model$sigma2) + (model$k - model$p) / sum(diag(P)))
    I2_each  <- model$sigma2 / (sum(model$sigma2) + (model$k - model$p) / sum(diag(P)))
    names(I2_each) = paste0("I2_", model$s.names)
    I2s <- c(I2_total = I2_total, I2_each)
    I2s
  }
</code>

Let's try this:
<codeblock id="fish_10">
No hints or solution necessary here.
</codeblock>

Our I^2 total is 95.4%. This is the sum of the heterogeneity due to between-study (13.3%), within-study (82.1%), and *genus* (with <0.001 negligible). If you run the model again without the specified random effects (using *rma* instead of *rma.mv*), you will see that I^2 (total heterogeneity / total variability) matches this value.

###At last, the model results! 
The estimate for mean effect size (across all studies, traits,...) is -0.8173. It is highly significant, as indicated by the *p*-value, the ci that do not overlap zero, and the three stars. This means that there is an overall strong effect of diet, leading to decreased trait values under low diet in fish.

##Meta-regression: Effects of moderators

In a next analysis,w e can ask whether potential predictor / moderator variables have an effect. Here, we want to know whether traits in different *trait categories* respond differently to diet manipulation. We simply add: <code>mods = ~ factor(trait_category)-1</code>.

<codeblock id="fish_10">
No hints or solution necessary here.
</codeblock>

###Publication bias

Publication bias is commonly observed in academic research. This is due to the fact that studies with significant results are often more likely to be published than studies with null results (despite equal quality of execution and design).

Publication bias can be assessed visually with funnel plots. If there is no indication of publication bias, studies (shown as single dots) will be plotted in a funnel shaped distribution. A deviation from this shape can indicate publication bias.

<codeblock id="fish_11">
No hints or solution necessary here.
</codeblock>



</exercise>



<exercise id="2" title="Report and interpret results">

# Writing it up


The [PRISMA checklist](http://prisma-statement.org/documents/PRISMA%202009%20checklist.pdf), which we used as our framework for conducting a systematic review, will give a good overview of all the things you need to report in or alongside your manuscript. 

The full-text screening of your included studies should have given you a very solid overview over the general background of your research question - so summarising this into a polished paper should be easy
![](https://github.com/SusZaj/metaanalysis/blob/master/images/wink.png?raw=true) 

</exercise>