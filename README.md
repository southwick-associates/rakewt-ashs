
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

- Target population was defined using the 2016 usfws national survey.
- One duplicate record was removed from the hunting survey dataset.
- Angler survey includes a decent percentage of zero (and missing) values for fish_avidity. An additional filter step was added to ensure these records were given a missing value for the output rake weight.
    + Note that weights were still calculated for records that include missing values in other target categories (income, etc.).
- Rake weights were capped at 20 in `anesrake()`. This only impacted the angler weights.
- Both angler and hunter scripts weight separately based on the Tablecat variable (4 categories). 
    + Iterating over TableCat was done using R's [for loops](https://www.datacamp.com/community/tutorials/tutorial-on-loops-in-r) and [apply functions](https://www.datacamp.com/community/tutorials/r-tutorial-apply-family).
    