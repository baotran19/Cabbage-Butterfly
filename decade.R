library(tidyverse)
library(dplyr)
library(readxl)
library(lubridate)

#set up working directory and the raw file
rm(list = ls())
setwd("/Users/baodinhgiatran/Desktop/DATA 332/cabbage_butterfly-main")
df <- read.csv("clean_data.csv")

#convert year to decade
df1 <- df %>%
  dplyr::select("coreid", "year")
df1$year <-substring(df1$year, 1,3)
df1$year <- paste(df1$year, "0s", sep = "")

#count number of records by decades
df2 <- df1 %>%
  count(year)

#plot a line graph
ggplot(data = df2, aes(x=year, y = n, group = 1)) +
  geom_line(color = "#FF6600") +
  ggtitle("Number of Butterflies recorded by Decades")+
  labs(x = "Decades", y = "Number of Butterflies")+ 
  geom_point(color = "#003399")+
  theme_minimal()