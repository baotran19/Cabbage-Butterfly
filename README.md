# Cabbage-Butterfly
We will analyze data of butterflies in this project <br>

The columns that were used are coreid, sex, country, year, left-wing width, left-wing length, left-wing apex, left-wing posterior spot, and left-wing anterior spot, and the same labels were used for the right-wing as the left-wing. The coreid is a unique ID for each butterfly that was recorded. Sex is stating whether the butterfly is male or female. The country is where the butterfly is from. The year is when the butterfly was recorded. The left-wing/right-wing width is the width of the wings in millimeters. The left-wing/right-wing length is the length of the wings in millimeters. The left-wing/right-wing apex column is the measurement from the tip of the wing to the bottom of the wing in millimeters. The left-wing/right-wing posterior spot is saying that the spot is in the bottom wing area. It is the measurement of how far the spot is from the vein of the wing. The left-wing/right-wing anterior is saying the spot is in the top wing area. It measures how far the spot is from the vein of the wing. 

Cleaning process:
    Gender:
        Male
        Female
        F
        M
        F?
        M?
        Unknown
        
Updated the sex column to reflect male or female. Some data was portrayed as F? or M? so we made a code to just have it formatted to be male or female. If the sex was blank then we made the data say unknown instead.

  `df$SexUpdated <- gsub("(?i)Female|(?i)F", "female",df$SexUpdated)
   df$SexUpdated <- gsub("(?i)Male|(?i)M", "male",df$SexUpdated)`

`df$SexUpdated[df$SexUpdated == "female?"] <- "female"`

`df$SexUpdated[df$SexUpdated =="male?"] <- "male"`

`df$SexUpdated[is.na(df$SexUpdated)] <- "unknown"`

    Location:
    
        For the country column, we created a code to make all countries formatted the same. For example for USA there were many different formats, such as U.S.A. and United States. So for United States we formatted it to be USA. If there was a blank then we looked at the locality and formatted the country to represent the locality. For example if the locality said Great Britain, then we said the country was United Kingdom.
      
`df$`dwc:country`<- gsub("(?i)United States|(?i)U.S.A.", "USA", df$`dwc:country`)`

`df$`dwc:country`[is.na(df$`dwc:country`)] <- "unknown"`

        
    Measurement = round up to the third decimal
    
    Made a code to format the measurements of the wings to reflect the same decimal points. We used the round function to round the measurements to 3 decimal places. Formated all the measurements to reflect number format instead of text format.

`df$LWingLength <- round(as.numeric(df$LWingLength), digits = 3)`

`df$LWingWidth <- round(as.numeric(df$LWingWidth), digits = 3)`

`df$LBlackPatchApex <- round(as.numeric(df$LBlackPatchApex),digits = 3)`

`df$LAnteriorSpotM3 <- round(as.numeric(df$LAnteriorSpotM3), digits = 3)`

`df$LPosteriorSpotCu2 <- round(as.numeric(df$LPosteriorSpotCu2), digits = 3)`

`df$RWingLength <- round(as.numeric(df$RWingLength), digits = 3)`

`df$RWingWidth <- round(as.numeric(df$RWingWidth), digits = 3)`

`df$RBlackPatchApex <- round(as.numeric(df$RBlackPatchApex), digits = 3)`

`df$RAnteriorSpotM3 <- round(as.numeric(df$RAnteriorSpotM3), digits = 3)`

`df$RPosteriorSpotCu2 <- round(as.numeric(df$RPosteriorSpotCu2), digits = 3)`

`df$YearUpdated <- as.numeric(df$YearUpdated)`

** Drop any record that have 1 N/A value

`df1 <- df %>%`

  `drop_na()`

  
Year Column:

Converted N/A values in year to reflect the YearUpdated column value

`df$YearUpdated[is.na(df$YearUpdated)] <- df$`dwc:year`[is.na(df$YearUpdated)]`

Get table visible:

Then we added code to select the certain columns that we wanted to be visible. 

`df <- df %>%'

  `dplyr::rename("country" = "dwc:country",`
  
                `"year" = "YearUpdated",`
                
                `"sex" = "SexUpdated") %>%`
                
  `dplyr::select("coreid", "sex", "LWingLength", "LWingWidth",`
  
                `"LBlackPatchApex", "LAnteriorSpotM3", "LPosteriorSpotCu2",`
                
                `"RWingLength", "RWingWidth", "RBlackPatchApex","RAnteriorSpotM3",`
                
                `"RPosteriorSpotCu2","year", "country")`

Sort the data:

We sorted the data by sex then country then year.

`df_butterfly <- df1 %>%`

  `arrange(sex, country, year)`



