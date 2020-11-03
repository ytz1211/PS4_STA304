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
# Read in the raw data. 
poststrat <- read_dta("inputs/data/usa_00003.dta"
                     )

# Add the labels
poststrat <- labelled::to_factor(poststrat)

# Just keep some variables that may be of interest (change 
# this depending on your interests)
names(poststrat)

# Select only the variables we want to analyze
postvars <- select(poststrat, age, educd, race, hhincome, region)

# Rename our variables to be consistent with the UCLA survey
postvars <- rename(postvars, race_ethnicity = race, census_region = region, household_income = hhincome, education = educd)

# Sort ages by age groups like the UCLA dataset
postvars$age <- as.numeric(postvars$age)
postvars <- mutate(postvars, age = case_when(age >= 18  & age <= 29 ~ "18 to 29",
                                                     age >= 30  & age <= 39 ~ "30 to 39",
                                                     age >= 40  & age <= 49 ~ "40 to 49",
                                                     age >= 50  & age <= 59 ~ "50 to 59",
                                                     age >= 60  & age <= 100 ~ "60+"))

# Clean up race values to correspond with UCLA data
postvars <- mutate(postvars, race_ethnicity = case_when(race_ethnicity == "white" ~ "White",
                                                            race_ethnicity == "black/african american/negro" ~ "Black, or African American",
                                                            race_ethnicity == "other race, nec" ~ "Some other race",
                                                            race_ethnicity == "american indian or alaska native" ~ "American Indian or Alaska Native",
                                                            race_ethnicity == "chinese" ~ "Asian",
                                                            race_ethnicity == "japanese" ~ "Asian",
                                                            race_ethnicity == "three or more major races" ~ "Some other race",
                                                            race_ethnicity == "two major races" ~ "Some other race",
                                                            race_ethnicity == "other asian or pacific islander" ~ "Pacific Islander",))

# Clean up post strata education values to correspond with UCLA data
postvars <- filter(postvars, education != "n/a")
postvars <- mutate(postvars, education = case_when(education == "regular high school diploma" ~ "High school graduate",
                                                   education == "some college, but less than 1 year" ~ "Completed some college, but no degree",
                                                   education == "grade 1" ~ "3rd Grade or less",
                                                   education == "grade 2" ~ "3rd Grade or less",
                                                   education == "grade 3" ~ "3rd Grade or less",
                                                   education == "grade 4" ~ "Middle School - Grades 4 - 8",
                                                   education == "grade 5" ~ "Middle School - Grades 4 - 8",
                                                   education == "grade 6" ~ "Middle School - Grades 4 - 8",
                                                   education == "grade 7" ~ "Middle School - Grades 4 - 8",
                                                   education == "grade 8" ~ "Middle School - Grades 4 - 8",
                                                   education == "grade 9" ~ "Completed some high school",
                                                   education == "grade 10" ~ "Completed some high school",
                                                   education == "grade 11" ~ "Completed some high school",
                                                   education == "12th grade, no diploma" ~ "Completed some high school",
                                                   education == "ged or alternative credential" ~ "High school graduate",
                                                   education == "1 or more years of college credit, no degree" ~ "Completed some college, but no degree",
                                                   education == "associate's degree, type not specified" ~ "Associate Degree",
                                                   education == "bachelor's degree" ~ "College Degree (such as B.A., B.S.)",
                                                   education == "master's degree" ~ "Masters degree",
                                                   education == "nursery school, preschool" ~ "3rd Grade or less",
                                                   education == "no schooling completed" ~ "3rd Grade or less",
                                                   education == "doctoral degree" ~ "Doctorate degree",
                                                   education == "professional degree beyond a bachelor's degree" ~ "College Degree (such as B.A., B.S.)",
                                                   education == "kindergarten" ~ "3rd Grade or less"))

# Group household income into brackets similar to UCLA data
postvars <- mutate(postvars, household_income = case_when(household_income >= 0  & household_income <= 14999 ~ "Less than $14,999",
                                                          household_income >= 15000  & household_income <= 19999 ~ "$15,000 to $19,999",
                                                          household_income >= 20000  & household_income <= 24999 ~ "$20,000 to $24,999",
                                                          household_income >= 25000  & household_income <= 29999 ~ "$25,000 to $29,999",
                                                          household_income >= 30000  & household_income <= 34999 ~ "$30,000 to $34,999",
                                                          household_income >= 35000  & household_income <= 39999 ~ "$35,000 to $39,999",
                                                          household_income >= 40000  & household_income <= 44999 ~ "$40,000 to $44,999",
                                                          household_income >= 45000  & household_income <= 49999 ~ "$45,000 to $49,999",
                                                          household_income >= 50000  & household_income <= 54999 ~ "$50,000 to $54,999",
                                                          household_income >= 55000  & household_income <= 59999 ~ "$55,000 to $59,999",
                                                          household_income >= 60000  & household_income <= 64999 ~ "$60,000 to $64,999",
                                                          household_income >= 65000  & household_income <= 69999 ~ "$65,000 to $69,999",
                                                          household_income >= 70000  & household_income <= 74999 ~ "$70,000 to $74,999",
                                                          household_income >= 75000  & household_income <= 79999 ~ "$75,000 to $79,999",
                                                          household_income >= 80000  & household_income <= 84999 ~ "$80,000 to $84,999",
                                                          household_income >= 85000  & household_income <= 89999 ~ "$85,000 to $89,999",
                                                          household_income >= 90000  & household_income <= 94999 ~ "$90,000 to $94,999",
                                                          household_income >= 95000  & household_income <= 99999 ~ "$95,000 to $99,999",
                                                          household_income >= 100000  & household_income <= 124999 ~ "$100,000 to $124,999",
                                                          household_income >= 125000  & household_income <= 149999 ~ "$125,000 to $149,999",
                                                          household_income >= 150000  & household_income <= 174999 ~ "$150,000 to $174,999",
                                                          household_income >= 175000  & household_income <= 199999 ~ "$175,000 to $199,999",
                                                          household_income >= 200000  & household_income <= 249999 ~ "$200,000 to $249,999",
                                                          household_income >= 250000  & household_income <= 1000000 ~ "$250,000 and above"))
postvars <- na.omit(postvars)

# Clean up post strat census region data to be consistent with UCLA data
postvars <- mutate(postvars, census_region = case_when(census_region == "new england division" ~ "Northeast",
                                                       census_region == "middle atlantic division" ~ "Northeast",
                                                       census_region == "east north central div" ~ "Midwest",
                                                       census_region == "west north central div" ~ "Midwest",
                                                       census_region == "south atlantic division" ~ "South",
                                                       census_region == "east south central div" ~ "South",
                                                       census_region == "west south central div" ~ "South",
                                                       census_region == "mountain division" ~ "West",
                                                       census_region == "pacific division" ~ "West"))
