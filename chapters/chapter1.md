---
title: 'Chapter 1: Getting started: Introduction to Lifespan-Analysis'
description:
  'This chapter will introduce background, definitions, and examples of lifespan analysis'
prev: null
next: chapter2
type: chapter
id: 1
---

<exercise id="1" title="Preface & Disclaimer">

# About this course

Hi and welcome, I am **[Felix Zajitschek](https://felix.zajitschek.net), an evolutionary biologist, working on topics such as aging and life-history that require to analyse or incorporate lifespan**. This course was co-developed with **[Susi Zajitschek (LJMU)](https://www.ljmu.ac.uk/about-us/staff-profiles/faculty-of-science/school-of-biological-and-environmental-sciences/susanne-zajitschek)** and is meant mainly as a primer for students who would like to know more about various methods which can be used to accomplish this. It will give you an overview of what can be done, how to perform a number of specific analyses, and where to go when you need to analyse more complex data.

All the actual statistical analyses are performed in the [software R](https://www.r-project.org/about.html), and you will have the opportunity to run R software scripts right here, on this website, without the need to install software on your computer.

![](https://github.com/zajitschek/lifespananalysis/blob/master/images/pushpin.svg?raw=true) Please note, if you plan on actually doing a meta-analysis yourself, beyond just going through this exercise, you will have to download R or [R studio](https://rstudio.com/products/rstudio/download/), if you haven't already. 

# How to use this resource

We will see why lifespan is a very important biological characteristic, explain what different measures of lifespan (such as average lifespan, survival, mortality, etc.) there are and why, and then go through worked examples.

You will also have the opportunity to perform steps directly in R, without having to open it locally. This will look like this grey block below. Just click on the "Run Code" button and see what happens. 
(You may need some patience - a couple of minutes - when you run the first  code block. This is because the R environment has to be loaded. Sometimes it may fail to connect the first time when you click RUN, so just re-run).

<codeblock id="intro_1">
Write your name where the dotted line is!
</codeblock>

You can also use the "Show hints", "Show solution" and "Reset" tabs. Don't worry about doing in anything "wrong" - you will not be breaking these code blocks! You can also use these blocks to calculate whatever else you think of - try for example writing "1+1", and run it again! (For advanced R users - you can't import your own datasets, but of course could add them manually!)

Each section may contain links, such as this [link to google scholar](https://scholar.google.com/), questions to answer (including feedback on getting it right or wrong), and tasks to do on your own - as indicated by this laptop icon  ![](https://github.com/zajitschek/lifespananalysis/blob/master/images/computertaskicon.svg?raw=true). If I think a note or resource is particularly useful, you will see this pushpin  ![](https://github.com/zajitschek/lifespananalysis/blob/master/images/pushpin.svg?raw=true).
<br>

Please note, this is meant as a quick primer to give you some overview of how lifespan can be analysed. If you're working on analyses for a publication, we highly recommend to check out some of the additional resources that are out there. Our resource here is only a starting point, and also does not cover the full range of R packages that are available for lifespan- and survival analyses.

For a small collection of freely available resources (that may be using other R packages) please see Chapter 5.

</exercise>

<exercise id="2" title="Introduction">

# Why is lifespan important in biology?   



Organisms are born, develop to maturation, reproduce, might care for their young, then die. This is a typical animal life-cycle. Genes, in interaction with the environment, regulate the expression of traits that characterize a life-cycle, such as body size at birth, rate of development, development time, time to maturation, age at first reproduction, number of offspring produced, rate of aging, and age at death. These traits are called **life-history traits**. 

Traits evolve by natural selection acting through the total number of offspring produced over an individual's lifespan - a proxy of the individual's evolutionary fitness. The better an organism is adapted, the more high quality offspring it produces. **Lifespan is one of the most important traits in life-history theory**, with the aim to explain the immense observed variation in life-cycles, life-history traits, and life-history strategies, across species, but also within species.

Before we jump right into different ways of analysing lifespan, it is necessary to take a step back and ask what we exactly mean by lifespan, and by related variables, such as birth, death, survival, and mortality. Let's start with lifespan itself: **What do we mean by lifespan?** The [Cambridge Dictionary](https://dictionary.cambridge.org/dictionary/english/lifespan) gives us the following definition: "the length of time for which a person, animal, or thing exists". 

Ok, so animal lifespan is accordingly the time between the start of the existence of an animal and the end point of its existence. Why didn't I use the words birth and death instead? Isn't it correct that an individual of an animal species that reproduces sexually starts existing when the egg cell (oocyte), provided by the female, successfully fuses with the sperm cell, provided by the male, and when the fertilized egg cell (zygote) blocks of other sperm cells to also fuse, so that the oocyte can develop? 

If we would use the latter definition, in humans called the conception, we would have to add nine month on average to every human lifespan, as given in official records. We normally use the date of birth as a starting point instead to calculate human lifespan. In the human case it gets even a little more complicated, because successful births don't have to be vaginal/natural any more, due to modern surgery. That means there is between-individual variation in the gestation period (how long a baby developed in the womb). In other animals, complications during birth (including premature birth) are normally fatal. However, whether a human baby is born at six months after fertilization or three months later, at 40 weeks after fertilization (which is the average length of human gestation), might not have a strong effect, given the relatively long human lifespan (compared to the gestation period). Death, on the other hand can normally be assessed much easier (although I will describe some circumstances when it's not possible to tell with high certainty whether an animal is alive or dead, eg when studying organisms in their natural habitat). 

We still have to be careful when referring to lifespan, as often in the scientific literature that is concerned with increasing lifespan through specific interventions, only 'adult lifespan' (the time between start of adulthood and death) is the focal trait. This is especially the case in species that are not eutherian (also called *placental*) mammals: in insects, for example, there exists a wide variety of life-cycles. In insects with holometabolous metamorphosis (also called *complete metamorphosis*), larval developmental stages are very different from the adult (think of fly, beetle, and butterfly species). This means that it's comparatively easy to determine the time point of the start of adult life (eg in many species, when adults eclose from their pupae into adulthood). It's not so easy in insect species with only partial metamorphosis (called *hemimetabolous*), such as grasshoppers and crickets. In these species, larvae develop in a succession of immature stages that already resemble the adult form. Fortunately, for well-studied species that have been used in laboratory experiments for decades, the time point when adulthood (maturity) starts can be predicted quite well under standardized environmental conditions that replicate previously implemented conditions.

Why is all this again important when we only want to analyse lifespan of a certain species? Because it turns out that some of these species, mentioned above, are used as model organisms in evolutionary biology and evolutionary ecology. It is essential to be aware that there might be differences in when (at what stage) experimental treatments are applied, which 'lifespan' is measured, and how this lifespan is measured, depending on the model organism. This doesn't mean that generalizations across different species are not possible! However, it means that different species, even in the same phylogenetic groups, might have quite different evolutionary histories, and therefore different adaptations and genetic architectures in general. Therefore, we have to acknowledge these differences when studying characters such as lifespan, and, whenever possible, aim to extend our research to incorporate experimental variability in environmental conditions which don't neglect the study species natural history.

## Characteristics of a life from birth to death

The life-history of an individual animal describes the time points of events, such as birth, developmental stage, begin of maturity/adulthood, age at first reproduction, age  and number of offspring of reproductive events, post-reproductive period, and age at death. A life-history also includes rates (change of traits over time), such as growth rate or reproductive rate. Life-histories can be described on the level of a species, a population, or for a single individual. Life-history traits are often very plastic. This means they can change, depending on environmental conditions (*phenotypic plasticity*). Lifespan is such a composite trait (a trait that is affected by so many variables), that even clones (individuals with identical genomes) in highly standardized and controlled laboratory environments don't all die at the same age (eg male Daphnia clones  (n = 50) with a median lifespan of 83 days and a 95% confidence interval around the median, from 77 to 91 days, reported in [Constantinou et al. 2019](https://www.sciencedirect.com/science/article/pii/S0531556519300762)). 

It's correct that even under the most standardized lab conditions there might be variation in variables we don't happen to measure / we can't measure, and therefore their effects can't be modelled to predict individual lifespan with greater certainty. However, there  seems to be component of a random / chaotic / stochastic variation in gene expression that affects lifespan and will, even in theory, be always in the way of predicting individual lifespan with absolute certainty.

# A short glimpse at some lifespan parameters

While we can measure lifespan for individual animals, survival and mortality rates are variables of populations of animals, not of single individuals. 



</exercise>

<exercise id="3" title="The structure of this course">

# Overview

This is meant as a first step to get you started.  Here's an overview of the workflow:

![](https://github.com/SusZaj/metaanalysis/blob/master/images/overview2.png?raw=true)
<br>
<br>

## Some examples 
Add here

- [Effects of nutrient limitation on sperm and seminal fluid: a systematic review and meta‐analysis (Macartney et al. 2019)](http://www.bonduriansky.net/Macartney_et_a_2019_Biological_Reviews.pdf) [Data & R code on osf.io](https://osf.io/aqw8u/)    
*Macartney, E.L., Crean, A.J., Nakagawa, S. and Bonduriansky, R. 2019. Effects of nutrient limitation on sperm and seminal fluid: a systematic review and meta-analysis. Biological Reviews 94:1722-1739*

- [The repeatability of behaviour: a meta-analysis (Bell et al. 2009)](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3972767/).   
*Bell, A. M., Hankison, S. J., & Laskowski, K. L. (2009). The repeatability of behaviour: a meta-analysis. Animal behaviour, 77(4), 771–783. https://doi.org/10.1016/j.anbehav.2008.12.022*

- [Meta-analysis reveals weak associations between intrinsic state and personality (Niemelä & Dingemanse 2018)](https://royalsocietypublishing.org/doi/10.1098/rspb.2017.2823).    
*Niemelä, P. T., & Dingemanse, N. J. (2018). Meta-analysis reveals weak associations between intrinsic state and personality. Proceedings. Biological sciences, 285(1873), 20172823. https://doi.org/10.1098/rspb.2017.2823*

- [The effect of dietary restriction on reproduction: a meta-analytic perspective (Moatt et al. 2016)](https://bmcevolbiol.biomedcentral.com/articles/10.1186/s12862-016-0768-z).   
*Moatt, J. P., Nakagawa, S., Lagisz, M., & Walling, C. A. (2016). The effect of dietary restriction on reproduction: a meta-analytic perspective. BMC evolutionary biology, 16(1), 199. https://doi.org/10.1186/s12862-016-0768-z*

</exercise>
