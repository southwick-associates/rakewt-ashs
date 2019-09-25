# rake weighting example

library(anesrake)
library(weights)
library(haven)
source("R/func.R") # est_wts()

# population distributions - 2016 usfws national survey, hunters
# - if using a reference dataset for population (e.g., license data), use:
#   pop <- sapply(variable_names, function(x) weights::wpct(dataset[[x]]))
pop <- list(
    region = c("1" = 0.1802, "2" = 0.1985, "3" = 0.0939, "4" = 0.2043, "5" = 0.2222, "6" = 0.101),
    agex2 = c("1" = 0.264, "2" = 0.362, "3" = 0.374),
    hincomex2 = c("1" = 0.136, "2" = 0.378, "3" = 0.486)
)

# load survey data
svy <- haven::read_sav("data/TOBEWEIGHTED_HS_TC1234_9.18.2019.sav")
svy <- data.frame(svy) # anesrake() won't work with haven's tbl_df class

# filter rows: use one category for this example
svy <- svy[svy$TableCat == 1,]

# check: distributions of weighting variables
sapply(names(pop), function(x) weights::wpct(svy[[x]]))

# check: make sure ID is unique (should show TRUE)
length(unique(svy$sguid)) == nrow(svy)

# run weighting
svy_wt <- est_wts(svy, pop)
