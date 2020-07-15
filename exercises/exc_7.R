###CODEBLOCK 7###

#Load packages
library(ggplot)

data(Aids2)

# View details about the 'Aids2' data
?Aids2

Aids2 %>% group_by(sex) %>% tally()

Aids2 %>% group_by(sex, T.categ) %>% tally()
          
# Plot
theme_set(theme_classic())
g <- ggplot(Aids2, aes(age))
g + geom_density(aes(fill=factor(sex)), alpha=0.8) + 
       facet_grid(state ~ 1) + 
       labs(title="Density plot", 
       subtitle="Lifespan grouped by sex and state",
       caption="Source: 'Aids2' data set",
       x="(Lifespan (age at death)",
       fill="State")






                        


