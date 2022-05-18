library(tidyverse)
library(dplyr)
library(readxl)
library(lubridate)
library(reshape)
library(ggpubr)

#set up working directory and the raw file
rm(list = ls())
setwd("/Users/baodinhgiatran/Desktop/DATA 332/cabbage_butterfly-main")
df <- read.csv("clean_data.csv")

#remove 0 values
df <- df %>%
  dplyr::select("coreid", "country", 
                "LWingLength", "LWingWidth","RWingLength", "RWingWidth") %>%
  dplyr::filter(LWingLength > 0, LWingWidth > 0, RWingLength > 0, RWingWidth >0)

#calculate average values of wing span
df_compare <- df %>%
  group_by(country) %>%
  summarise(`Left Wing Length` = mean(LWingLength), `Left Wing Width` = mean(LWingWidth), 
            `Right Wing Length` = mean(RWingLength), `Right Wing Width` = mean(RWingWidth))

#tidy data
df_longer <- pivot_longer(df_compare, cols = 2:5, names_to = "functions", values_to = "measurement")

#reorder by continent
df_longer$country <- factor(df_longer$country, 
                            levels = c("Canada", "United States", "United Kingdom", "Republic of Ireland"))

#create visualization
ggplot(df_longer, aes(fill = country, x = functions, y = measurement))+
  geom_bar(position = "dodge", stat = "identity") + theme_minimal()+
  ggtitle("Wingspan Size by Country") + ylim(0, 30)+
  labs(x = "", y = "") +
  scale_fill_manual(values = c("#CC3333", "#333399", "#FFCC00", "#FF9933"), 
                    name = "Country")
          

