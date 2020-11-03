# Overview

This repo contains code and data for forecasting the US 2020 presidential election. It was created by Alex (Zikun) Xu and Yitian Zhao. The purpose is to create a report that summarises the results of a statistical model that we built. Some data is unable to be shared publicly. We detail how to get that below. The sections of this repo are: inputs, outputs, scripts.

Inputs contain data that are unchanged from their original. We use two datasets: 

- UCLA Nationscape Dataset - from https://www.voterstudygroup.org/publication/nationscape-data-set
- 2018 ACS data - from https://doi.org/10.18128/D010.V10.0

Outputs contain data that are modified from the input data, the report and supporting material.

- reduced_data, using 7 main variables from the input dataset, raw_data, and cleaned to match model requirements (as factors)
- postvars,  using 5 main variables from the post stratification data set and cleaned to match model requirements (as factors)

Scripts contain R scripts that take inputs and outputs and clean/produce outputs. These are:

- 01_data_cleaning.R
- 02_data_preparation.R

We ran into an issue knitting the paper.rmd as a .pdf itself. For reproducibility, we are knitting it to a .html and then converting that into a .pdf.



