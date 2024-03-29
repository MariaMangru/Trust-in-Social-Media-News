#### Preamble ####
# Purpose: Exploration of the dataset to gather trends and determine appropriate models  
# Author: Maria Mangru
# Date: March 2024
# Contact:maria.mangru@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(dplyr)
library(tidyr)
library(ggplot2)

cleaned_data <- read_csv("data/analysis_data/analysis_data.csv")


#### Creating Summary Statistics and Visualizations ####

## Create summary table ## 

# fix table based on what the quarto output looks like 

summary_table <- cleaned_data %>%
  group_by(Gender, `Sociodemographic characteristics`, Indicators) %>%
  summarise(
    Avg_Percent = mean(Percent, na.rm = TRUE),
    Avg_Number = mean(Number, na.rm = TRUE),
    .groups = 'drop'
  )
view(summary_table)


## Create Visualization ##

# Line graph for average trust rating percent by age group ## 
ggplot(summary_table, aes(x = `Sociodemographic characteristics`, y = Avg_Percent, fill = Indicators)) +
  geom_col(position = position_dodge(width = 0.7)) + 
  facet_wrap(~Gender) +
  labs(x = "Age Group", y = "Average Percent Trust Rating", fill = "Trust Rating") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


### Save plot ##
ggsave("./other/outputs/avg_trust_rating_by_age.png")


