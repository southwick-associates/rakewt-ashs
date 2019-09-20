# rake weighting for hunters

library(anesrake)
library(weights)
library(haven)
source("R/func.R")

svy_file <- "data/TOBEWEIGHTED_HS_TC1234_9.18.2019.sav"
out_file <- "out/weights-hs.csv"

# population distributions
pop <- list(
    region = c("1" = 0.1802, "2" = 0.1985, "3" = 0.0939, "4" = 0.2043, "5" = 0.2222, "6" = 0.101),
    agex2 = c("1" = 0.264, "2" = 0.362, "3" = 0.374),
    hincomex2 = c("1" = 0.136, "2" = 0.378, "3" = 0.486)
)

# Load Survey Data ----------------------------------------------------------

svy <- data.frame(haven::read_sav(svy_file))

# check: overall distributions of weighting variables
sapply(names(pop), function(x) weights::wpct(svy[[x]]))

# weights will be run separately by Tablecat
svy <- split(svy, svy$TableCat)

# check: make sure ID is unique (should all show TRUE)
lapply(svy, function(x) length(unique(x$sguid)) == nrow(x))

# remove duplicate records
svy <- lapply(svy, unique)
lapply(svy, function(x) length(unique(x$sguid)) == nrow(x))

# Run Weighting -----------------------------------------------------------

svy_wt <- lapply(seq_along(svy), function(i) est_wts(svy[[i]], pop, names(svy)[[i]]))
svy_wt <- do.call(rbind, svy_wt)

# save
write.csv(svy_wt, out_file, row.names = FALSE, na = "")
