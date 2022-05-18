library(tidyverse)
library(dplyr)
library(readxl)
library(lubridate)
library(ggplot2)

#set up directory
rm(list = ls())
setwd("/Users/baodinhgiatran/Desktop/DATA 332/cabbage_butterfly-main")
df <- read.csv("clean_data.csv")

#remove unknown sex value
df1 <-subset(df, sex != "unknown")

#count number of records by country and sex
df2 <- df1 %>%
  group_by(sex) %>%
  count(country)

#plot a bar chart
ggplot(df2, aes(fill = sex, y = n, x = country)) +
  geom_bar(position = "stack", stat = "identity") +
  ggtitle("Number of Butterflies recorded by Sex and Country") +
  labs(x = "Countries", y = "Number of Butterflies") +
  scale_fill_manual(values = c("#FFCC33", "#003366"), 
                    name = "Sex", labels = c("Female", "Male"))+
  theme_minimal()
