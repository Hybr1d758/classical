# Install and load required packages
install.packages("dplyr")
install.packages("tidyverse")
install.packages("ggplot2")
install.packages("readr")
install.packages("tidyr")
install.packages("readxl")

library(dplyr)
library(tidyverse)
library(ggplot2)
library(readr)
library(tidyr)
library(readxl)
# Load the dataset
data <- read_excel("/Users/edwardjr/Documents/Data Science/R.Studio/Projects/Classic Music/classical/mbb.xlsx")

# View the first few rows of the dataset
head(data)

# View the column names
colnames(data)

# Ensure the Month column is character or factor, and then convert to numeric after pivoting
data$Month <- as.character(data$Month)

# Reshape the data from wide to long format
data_long <- data %>%
  pivot_longer(cols = c("Mozart", "Beethoven", "Bach"), 
               names_to = "Composer", 
               values_to = "Listen_Count")

# View the first few rows of the reshaped data
head(data_long)

# Check the structure of the reshaped data
str(data_long)

# Convert Month to numeric after pivoting
data_long$Month <- as.numeric(data_long$Month)


clean_data_long <- data_long %>%
  mutate(Listen_Count = replace(Listen_Count, is.na(Listen_Count), median(Listen_Count, na.rm = TRUE)))


# Bar plot of total listens per composer
ggplot(clean_data_long, aes(x = Composer, y = Listen_Count, fill = Composer)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Total Listens Per Composer",
       x = "Composer",
       y = "Total Listen Count") +
  theme_minimal()

       