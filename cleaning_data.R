library(tidyverse)
library(dplyr)
library(readxl)
library(lubridate)

rm(list = ls())
setwd("H:/Cabbage-Butterfly")
df <- read_excel("data/CompletePierisData_2022-03-09.xlsx") 
  
#clean sex column
df$SexUpdated <- gsub("(?i)Female|(?i)F", "female",df$SexUpdated)
df$SexUpdated <- gsub("(?i)Male|(?i)M", "male",df$SexUpdated)
df$SexUpdated[df$SexUpdated == "female?"] <- "female"
df$SexUpdated[df$SexUpdated =="male?"] <- "male"
df$SexUpdated[is.na(df$SexUpdated)] <- "unknown"

#clean country column
df$`dwc:country`<- gsub("(?i)United States|(?i)U.S.A.", "USA", df$`dwc:country`)
df$`dwc:country`[is.na(df$`dwc:country`)] <- "unknown"

#clean year column
df$YearUpdated[is.na(df$YearUpdated)] <- df$`dwc:year`[is.na(df$YearUpdated)]

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
df <- df %>%
  dplyr::rename("country" = "dwc:country", 
                "year" = "YearUpdated") %>%
  dplyr::select("coreid", "SexUpdated", "LWingLength", "LWingWidth",
                "LBlackPatchApex", "LAnteriorSpotM3", "LPosteriorSpotCu2", 
                "RWingLength", "RWingWidth", "RBlackPatchApex","RAnteriorSpotM3", 
                "RPosteriorSpotCu2","year", "country")

df <- df %>%
  drop_na()
