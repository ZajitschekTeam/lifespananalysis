###CODEBLOCK 6###

#Load packages
suppressMessages(library(ggplot2))
suppressMessages(library(dplyr))

# Load fly lifespan data, extracted from the data set for Zajitschek et al 2016 Proc B
data1 <- read.csv("https://github.com/ZajitschekTeam/lifespananalysis/raw/master/binder/data/expevol_male_flies.csv")

# Always change numeric values (both data types 'int' and 'num') that don't hold any 
# meaningful numeric information into factors
data1 <- data1 %>% mutate(across(where(is.integer), as.factor))
          
# Have a look at its structure
str(data1)
glimpse(data1)

data1 %>% group_by(cage) %>% count()

# How many lifespan values per vial  
data1 %>% group_by(vial) %>% count()

# How many vials per treatment (cagediet x assaydiet combination)         
data1 %>% group_by(cage, cagediet, assaydiet) %>% summarise(n_distinct(vial))
         
# If you want to print all rows, use the following code
#data1 %>% group_by(cage, cagediet, assaydiet) %>% summarise(n_distinct(vial)) %>% 
#    print(n = 300)
         
theme_set(theme_classic())
g <- ggplot(data1, aes(lifespan))
g + geom_density(aes(fill=factor(assaydiet)), alpha=0.8) + 
  facet_grid(cagediet ~ 1) + 
  labs(title="Density plot", 
       subtitle="Lifespan grouped by source cage and assay diet",
       caption="Source: 'Zajitschek et al 2016 Proc B",
       x="(Lifespan (age at death)[days of adulthood]",
       fill="Cagediet")

theme_set(theme_classic())
g <- ggplot(data1, aes(lifespan))
g + geom_histogram(aes(fill=factor(assaydiet)), , bins= 15, alpha=0.8) + 
  facet_grid(cagediet ~ assaydiet) + 
  labs(title="Density plot", 
       subtitle="Lifespan by grouped source cage and assay diet",
       caption="Source: 'Zajitschek et al 2016 Proc B",
       x="(Lifespan (age at death)[days of adulthood]",
       fill="Assay diet")

g <- ggplot(data1, aes(lifespan))
g + geom_histogram(aes(fill=factor(assaydiet)), , bins= 15, alpha=0.8) + 
  facet_grid(cagediet ~ 1) + 
  labs(title="Density plot", 
       subtitle="Lifespan grouped by source cage and assay diet",
       caption="Source: 'Zajitschek et al 2016 Proc B",
       x="(Lifespan (age at death)[days of adulthood]",
       fill="Assay diet") +
  theme_classic()

boxplot(lifespan ~ cage*assaydiet*vial, data= data1)

g <- ggplot(data1, aes(y= lifespan))
g + geom_boxplot(aes(fill= factor(assaydiet))) + 
  facet_grid(assaydiet ~ cage) + 
  labs(title="Boxplots", 
       subtitle="Lifespan grouped by source cage and assay diet",
       caption="Source: 'Zajitschek et al 2016 Proc B",
       x="(Lifespan (age at death)[days of adulthood]",
       fill="Assay diet") +
  theme_classic()
                        


