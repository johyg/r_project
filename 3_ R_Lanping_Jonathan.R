#####################################
# Group assignment 3
# Lanping Wei & Jonathan Hygrell
# DS21 Solna
#####################################

#Find a murderer, given a dataset, time frame and phone model

library(tidyverse)
library(stringr)
#Read csv file into a avriable df_tele
df_tele <- read.csv("telemastdata.CSV") 

#Make a dataframe for suspects and filter by timestamps and model of telephone
df_sus <- df_tele %>% 
  filter(phone_type=="iPhone" & between(time0,407,425)) 

#Show table with the results
View(df_sus)


