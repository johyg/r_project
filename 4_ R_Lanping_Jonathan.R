#####################################
# Group assignment 4
# Lanping Wei & Jonathan Hygrell
# DS21 Solna
#####################################

#Lung cancer predictions using Linear Regression

install.packages("psych")
library(tidyverse)
library(ggplot2)
library(stringr)
library(psych)

#Load dataset into variable df_lung
df_lung <- read.csv("LungCap.csv", stringsAsFactors = T)
df_lung

#Use boxplot to see if there are any outliers
boxplot(df_lung)

#Line 89 in the dataset contains and outlier with an unrealistic value, we chose to exclude it from the dataframe
df_lung <- df_lung[-89,]
head(df_lung)

#Generate random seed
set.seed(123) 

#Divide data in train and test dataset
index <-  sample(1:nrow(df_lung), 0.7*nrow(df_lung)) 
train_data <-  df_lung[index,] 
test_data <-  df_lung[-index,]

#Include all columns and decide which columns to remove because of statistical insignificance
lin_mod <- lm(LungCap ~ ., data = train_data)
summary(lin_mod)

#Above results suggests new_var1,2,4,5,6 can be removed
#Because Pr(>|t|) gives high values for the null hypothesis //ger höga värden för null-hypotes
lin_mod <- lm(LungCap ~ Age + Height + new_var3, data = train_data)
summary(lin_mod)
# r squared 0.858 


pred <- predict(lin_mod, test_data)
summary(pred)
