library(tidyverse)
library(dplyr)
library(readxl)
library(lubridate)

rm(list = ls())
setwd("H:/Cabbage-Butterfly")
df <- read_excel("data/CompletePierisData_2022-03-09.xlsx") 
  
df$SexUpdated <- gsub("(?i)Female|(?i)F", "female",df$SexUpdated)
df$SexUpdated <- gsub("(?i)Male|(?i)M", "male",df$SexUpdated)
df$SexUpdated[df$SexUpdated == "female?"] <- "female"
df$SexUpdated[df$SexUpdated =="male?"] <- "male"
df$SexUpdated[is.na(df$SexUpdated)] <- "unknown"

df$`dwc:country`<- gsub("(?i)United States|(?i)U.S.A.", "USA", df$`dwc:country`)
df$`dwc:country`[is.na(df$`dwc:country`)] <- "unknown"

df$`dwc:year`[is.na(df$`dwc:year`)] <- df$YearUpdated[is.na(df$`dwc:year`)]

#df$SexUpdated <- gsub("(?i)Male|(?i)M", "male",df$SexUpdated)
#df$SexUpdated[df$SexUpdated == "female?"] <- "female"
#df$SexUpdated[df$SexUpdated =="male?"] <- "male"
#df$SexUpdated[is.na(df$SexUpdated)] <- "unknown"

df$LWingLength <- round(df$LWingLength, digits = 3)
df <- df %>%
  dplyr::rename("country" = "dwc:country", 
                "year" = "dwc:year") %>%
  dplyr::select("coreid", "SexUpdated", "LWingLength", "LWingWidth",
                "LBlackPatchApex", "LAnteriorSpotM3", "LPosteriorSpotCu2", 
                "RWingLength", "RWingWidth", "RBlackPatchApex","RAnteriorSpotM3", 
                "RPosteriorSpotCu2","year", "country")
