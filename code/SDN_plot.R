
# load required packages
library(ggplot2)
library(haven)

# input data
data <- read_dta("code/SDN_example.dta")

# plot base
baseplot = ggplot() + theme_bw() + 
  labs(x="Welfare/day (2017 PPP)", y="Density") 

# plot additions
baseplot + 
  geom_density(aes(x=welfare2014, weight=weight,fill="2014"),
               data=data, linetype=1, alpha=0.7) + 
  geom_density(aes(x=welfare2019, weight=weight,fill="2019"),
               data=data, linetype=2, alpha=0.5)  + 
  geom_vline(xintercept=2.15, linetype = "dashed", color = "red") +
  scale_fill_manual(values=c('2019'="steelblue", '2014'="black")) +
  theme(legend.position = c(.75,.77), # (1,1) is top right
        legend.direction="vertical", 
        legend.title = element_blank(), ## no title
        legend.margin = margin(-0.5,0,0,0, unit="cm")) + # decreases the margin between legends
  scale_x_continuous(
    breaks=c(2.15,3.65,6.85), 
    labels=sprintf("%.2f",c(2.15,3.65,6.85)),
    limits = c(0,10)) +
  scale_y_continuous(
    limits = c(0,0.3)) 
