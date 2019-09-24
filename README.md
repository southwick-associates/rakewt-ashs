
# Rake Weighting for Angler/Hunter Survey

Includes code for rake weighting in R in Sep 2019. Takes input survey ("data" folder) and returns weighted survey data in the "out" folder. The code relies primarily on R [package anesrake](https://cran.r-project.org/web/packages/anesrake/index.html) and was adapted from Tom's SPSS code ("spss_code" folder).

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

- Target population is defined by the 2016 usfws national survey.
- One duplicate record was removed from the hunting survey dataset.
- Angler survey includes a decent percentage of zero (and missing) values for fish_avidity:
    + The `anesrake()` procedure cannot account for zero values since that category is not included in the target population.
    + Normally `anesrake()` will still calculate weight when missing values in target categories are present. In this case, rake_wt was set to missing for missing values in fish_avidity. 
- Both angler and hunter scripts weight separately based on the Tablecat variable (4 categories). 
    + Iterating over TableCat was done using R's [for loops](https://www.datacamp.com/community/tutorials/tutorial-on-loops-in-r) and [apply functions](https://www.datacamp.com/community/tutorials/r-tutorial-apply-family).
    