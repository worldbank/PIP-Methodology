
# load required packages
library(ggplot2)
library(haven)

# input data
setwd("C:/Users/wb562356/OneDrive - WBG/Documents/PovcalNet_Data_Stuff/ETHdist_example")
data <- read_dta("ETHdist_example.dta")

# plot base
baseplot = ggplot() + theme_bw() + 
  labs(x="Welfare/day (2011 PPP)", y="Density") 

# plot additions
baseplot + 
  geom_density(aes(x=welf2011ppp_20155, fill="2015.5"),
               data=data, linetype=1, alpha=0.7) + 
  geom_density(aes(x=welf2011ppp_2018, fill="2018"),
               data=data, linetype=2, alpha=0.5)  + 
  geom_vline(xintercept=1.9, linetype = "dashed", color = "red") +
  scale_fill_manual(values=c('2018'="steelblue", '2015.5'="black")) +
  theme(legend.position = c(.75,.77), # (1,1) is top right
        legend.direction="vertical", 
        legend.title = element_blank(), ## no title
        legend.margin = margin(-0.5,0,0,0, unit="cm")) + # decreases the margin between legends
  scale_x_continuous(
    breaks=c(1.9,3.2,5.5), 
    labels=sprintf("%.1f",c(1.9,3.2,5.5)),
    limits = c(0,10)) +
  scale_y_continuous(
    limits = c(0,0.35)) 
