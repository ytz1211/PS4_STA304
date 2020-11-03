#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from Rohan Alexander
# Author: Alex (Zikun) Xu and Yitian Zhao
# Data: 2 November 2020
# Contact: ytz.zhao@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the ACS data and saved it to inputs/data
# - Don't forget to gitignore it!


#### Workspace setup ####
library(haven)
library(tidyverse)
# Read in the raw data (You might need to change this if you use a different dataset)
raw_data <- read_dta("inputs/data/ns20200625/ns20200625.dta")
# Add the labels
raw_data <- labelled::to_factor(raw_data)
# Just keep some variables for our model
reduced_data <- select(raw_data, vote_2020, age, education, race_ethnicity, household_income, census_region)


# Clean up age to be sorted into age groups
reduced_data <- mutate(reduced_data, age = case_when(age >= 18  & age <= 29 ~ "18 to 29",
                                                     age >= 30  & age <= 39 ~ "30 to 39",
                                                     age >= 40  & age <= 49 ~ "40 to 49",
                                                     age >= 50  & age <= 59 ~ "50 to 59",
                                                     age >= 60  & age <= 100 ~ "60+"))


# Clean up race values in the data set
reduced_data <- mutate(reduced_data, race_ethnicity = case_when(race_ethnicity == "Asian (Chinese)" ~ "Asian",
                                                                race_ethnicity == "Asian (Korean)" ~ "Asian",
                                                                race_ethnicity == "Asian (Other)" ~ "Asian",
                                                                race_ethnicity == "Asian (Asian Indian)" ~ "Asian",
                                                                race_ethnicity == "Asian (Vietnamese)" ~ "Asian",
                                                                race_ethnicity == "Asian (Japanese)" ~ "Asian",
                                                                race_ethnicity == "Asian (Filipino)" ~ "Asian",
                                                                race_ethnicity == "Pacific Islander (Native Hawaiian)" ~ "Pacific Islander",
                                                                race_ethnicity == "Pacific Islander (Other)" ~ "Pacific Islander",
                                                                race_ethnicity == "Pacific Islander (Samoan)" ~ "Pacific Islander",
                                                                race_ethnicity == "Pacific Islander (Guamanian)" ~ "Pacific Islander",
                                                                race_ethnicity == "White" ~ "White",
                                                                race_ethnicity == "Black, or African American" ~ "Black, or African American",
                                                                race_ethnicity == "American Indian or Alaska Native" ~ "American Indian or Alaska Native",
                                                                race_ethnicity == "Some other race" ~ "Some other race"))

reduced_data <- filter(reduced_data, vote_2020 == "Donald Trump" | vote_2020 == "Joe Biden")

