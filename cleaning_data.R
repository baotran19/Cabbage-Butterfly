library(tidyverse)
library(dplyr)
library(readxl)
library(lubridate)

#set up working directory and the raw file
rm(list = ls())
setwd("/Users/baodinhgiatran/Desktop/DATA 332/cabbage_butterfly-main")
df <- read_excel("data/CompletePierisData_2022-03-09.xlsx") 

df %>%
  dplyr::distinct(coreid)

#clean sex column
df$SexUpdated[df$SexUpdated == "Female"] <- "female"
df$SexUpdated[df$SexUpdated == "F"] <- "female"
df$SexUpdated[df$SexUpdated == "Male"] <- "male"
df$SexUpdated[df$SexUpdated == "M"] <- "male"
df$SexUpdated[df$SexUpdated == "female?"] <- "unknown"
df$SexUpdated[df$SexUpdated =="male?"] <- "unknown"
df$SexUpdated[is.na(df$SexUpdated)] <- "unknown"


#clean country column
df$`dwc:country`<- gsub("(?i)USA|(?i)U.S.A.", "United States", df$`dwc:country`)
df$`dwc:country`[is.na(df$`dwc:country`)] <- "United Kingdom"

#clean year column
df$YearUpdated[is.na(df$YearUpdated)] <- df$`dwc:year`[is.na(df$YearUpdated)]
df$YearUpdated[df$YearUpdated == 200] <- 2000

#convert data type
df$LWingLength <- round(as.numeric(df$LWingLength), digits = 3)
df$LWingWidth <- round(as.numeric(df$LWingWidth), digits = 3)
df$LBlackPatchApex <- round(as.numeric(df$LBlackPatchApex),digits = 3)
df$LAnteriorSpotM3 <- round(as.numeric(df$LAnteriorSpotM3), digits = 3)
df$LPosteriorSpotCu2 <- round(as.numeric(df$LPosteriorSpotCu2), digits = 3)
df$RWingLength <- round(as.numeric(df$RWingLength), digits = 3)
df$RWingWidth <- round(as.numeric(df$RWingWidth), digits = 3)
df$RBlackPatchApex <- round(as.numeric(df$RBlackPatchApex), digits = 3)
df$RAnteriorSpotM3 <- round(as.numeric(df$RAnteriorSpotM3), digits = 3)
df$RPosteriorSpotCu2 <- round(as.numeric(df$RPosteriorSpotCu2), digits = 3)
df$YearUpdated <- as.numeric(df$YearUpdated)



#return result
df1 <- df %>%
  dplyr::rename("country" = "dwc:country", 
                "year" = "YearUpdated",
                "sex" = "SexUpdated") %>%
  dplyr::select("coreid", "sex", "LWingLength", "LWingWidth",
                "LBlackPatchApex", "LAnteriorSpotM3", "LPosteriorSpotCu2", 
                "RWingLength", "RWingWidth", "RBlackPatchApex","RAnteriorSpotM3", 
                "RPosteriorSpotCu2","year", "country")

#remove rows with NA values
df2 <- df1 %>%
  drop_na()

#sort by sex, year, and country
df_butterfly <- df2 %>%
  arrange(sex, year, country)

#export clean file
write.csv(df_butterfly, "/Users/baodinhgiatran/Desktop/DATA 332/cabbage_butterfly-main/clean_data.csv", row.names = FALSE)
