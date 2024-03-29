#### Preamble ####
# Purpose: Cleans the raw traffic counts recorded into a more manageable dataset 
# Author: Maria Mangru
# Date: March 2024
# Contact:maria.mangru@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(tidyverse)
library(dplyr)

#### Clean data ####

## Load raw data ##
raw_data <- read_csv("data/raw_data/raw_data.csv")

## Remove columns which are note needed ##
cleaned_data <- raw_data[, !names(raw_data) %in% c("GEO", "SCALAR_ID", "SYMBOL", "TERMINATED", "DECIMALS", "UOM_ID", "VECTOR", "COORDINATE")]


## Remove rows with STATUS of F or ... ##
cleaned_data <- cleaned_data[!cleaned_data$STATUS %in% c("E", "F", ".."), ]


## Renaming the values in Indicator column for simplicity and readability ##
cleaned_data <- cleaned_data %>%
  mutate(Indicators = recode(Indicators, 
                             "Trust in news or information from social media rating between 0 and 5" = "Rating 0-5",
                             "Trust in news or information from social media rating of 6 or 7" = "Rating 6-7",
                             "Trust in news or information from social media rating of 8, 9 or 10" = "Rating 8-10"))

## Splitting Value column into Percent and Number columns ##

cleaned_data <- cleaned_data %>%
  mutate(VALUE = as.numeric(VALUE)) # check Value data type 

## Create new columns and split the data ## 
cleaned_data <- cleaned_data %>%
  mutate(
    Percent = if_else(UOM == "Percent", VALUE, NA_real_),
    Number = if_else(UOM == "Number", VALUE, NA_real_)
  ) %>%
  select(-UOM, -VALUE)


#### Save data ####
write_csv(cleaned_data, "data/analysis_data/analysis_data.csv")
