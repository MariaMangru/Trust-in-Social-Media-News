#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

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


#### Save data ####
write_csv(cleaned_data, "data/analysis_data/analysis_data.csv")
