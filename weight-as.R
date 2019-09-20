# rake weighting for anglers

library(anesrake)
library(weights)
library(haven)
source("R/func.R")

svy_file <- "data/orig only AS TC1234 TOBEWEIGHTED 9.18.19.sav"
out_file <- "out/weights-as.csv"

# population distributions
pop <- list(
    region = c("1" = 0.1373, "2" = 0.2004, "3" = 0.0775, "4" = 0.226, "5" = 0.238, "6" = 0.1209),
    agex2 = c("1" = 0.231, "2" = 0.384, "3" = 0.385),
    hincomex2 = c("1" = 0.258, "2" = 0.295, "3" = 0.447),
    fish_avidity = c("1" = 0.531, "2" = 0.214, "3" = 0.105, "4" = 0.149)
)

# Load Survey Data ----------------------------------------------------------

svy <- data.frame(haven::read_sav(svy_file))

# check: overall distributions of weighting variables
sapply(names(pop), function(x) weights::wpct(svy[[x]]))

# weights will be run separately by Tablecat
svy <- split(svy, svy$TableCat)

# check: make sure ID is unique (should all show TRUE)
lapply(svy, function(x) length(unique(x$sguid)) == nrow(x))

# Run Weighting -----------------------------------------------------------

# apply a filter prior to weighting
# - records with zero values for fish avidity won't compute rake_wt (it will be missing)
x <- lapply(svy, function(x) x[x$fish_avidity != 0,])

# apply weighting by TableCat
svy_wt <- lapply(seq_along(x), function(i) est_wts(x[[i]], pop, names(x)[[i]]))
svy_wt <- lapply(svy_wt, function(x) x[c("sguid", "rake_wt")])

# merge back with unfiltered survey data
svy_wt <- mapply(merge, svy, svy_wt, MoreArgs = list(by = "sguid", all.x = TRUE),
                 SIMPLIFY = FALSE)
svy_wt <- do.call(rbind, svy_wt)

# save
write.csv(svy_wt, out_file, row.names = FALSE, na = "")
