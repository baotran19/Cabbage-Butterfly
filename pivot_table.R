library(tidyverse)
library(dplyr)

#set up directory
rm(list = ls())
setwd("/Users/baodinhgiatran/Desktop/DATA 332/cabbage_butterfly-main")
df <- read.csv("clean_data.csv")

#remove unknown sex value
df <-subset(df, sex != "unknown")

#Group years into decade
df$year <- substr(df$year,1,3)
df$year <- paste(df$year,sep='',"0s")

#Pivot Table
pt <- df %>%
  dplyr::select("year","sex","country") %>%
  group_by(country,sex,year) %>%
  summarize(numRecord = n()) %>%
  pivot_wider(names_from = sex, values_from = numRecord) #convert the gender into 2 columns

pt <- pt%>%
  arrange(country, year)