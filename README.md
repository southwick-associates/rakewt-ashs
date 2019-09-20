
# Rake Weighting for Angler/Hunter Survey

Includes code for rake weighting in R in Sep 2019. Takes input survey ("data" folder) and returns weighted survey data in the "out" folder. Relies primarily on R [package anesrake](https://cran.r-project.org/web/packages/anesrake/index.html)

## Installation

You'll need [R installed](https://www.r-project.org/), and 3 packages:

``` r
install.packages(c("anesrake", "weights", "haven"))
```

## Usage

I recommend `weight-example.R` as a starting point for adapting this workflow for future iterations (or another project). This code reproduces the weighting:

``` r
# run weighting with log summaries
sink("log/weights-hs.txt")
source("weight-hs.R")
sink()

sink("log/weights-as.txt")
source("weight-as.R")
sink()
```

## Data Notes

- Both anglers and hunter scripts weight separately based on the Tablecat variable (4 categories).
- Target population is defined by the 2016 usfws national survey.
- Adapted from Tom's code stored in the "spss_code" folder.
- Angler survey includes missing values for fish_avidity. The rake_wt was set to missing for these records.
