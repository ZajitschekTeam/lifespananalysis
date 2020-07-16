###CODEBLOCK 6###

#Load packages
suppressMessages(library(ggplot2))
suppressMessages((library(dplyr))

# Load fly lifespan data, extracted from the data set for Zajitschek et al 2016 Proc B
data1 <- read.csv("expevol_male_flies.csv")

# Always change numeric values (both data types 'int' and 'num') that don't hold any 
# meaningful numeric information into factors
data1 <- data1 %>% mutate(across(where(is.integer), as.factor))
          
# Have a look at its structure
str(data1)
glimpse(data1)

# How many source cages and how many lifespan values per cage          
data1 %>% group_by(cage) %>% tally()

# How many assay diets and how many lifespan values per cage per assay diet   
data1 %>% group_by(cage, assaydiet) %>% tally()

# How many vials per diet treatment combination
data1 %>% group_by(cage, assaydiet) %>% summarise(n_distinct(vial))

# How many lifespan values per vial (the lowest level)          
data1 %>% group_by(cage, assaydiet, vial) %>% tally()
         
# If you want to print all rows, use the following code
# data1 %>% group_by(cage, assaydiet, vial) %>% tally() %>% 
#    print(n = 300)

# Plot histograms 
theme_set(theme_classic())
g <- ggplot(data1, aes(lifespan))
g + geom_histogram(aes(fill=factor(assaydiet)), , bins= 15, alpha=0.8) + 
  facet_grid(cagediet ~ 1) + 
  labs(title="Density plot", 
       subtitle="Lifespan grouped by source cage and coloured by assay diet",
       caption="Source: 'Zajitschek 2016 Proc B",
       x="(Lifespan (age at death)[days of adulthood]",
       fill="Assay diet")





                        


