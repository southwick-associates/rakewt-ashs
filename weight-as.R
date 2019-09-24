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

# split into a list: weights will be run separately by Tablecat
svy <- split(svy, svy$TableCat)

# check: make sure ID is unique (should all show TRUE)
lapply(svy, function(x) length(unique(x$sguid)) == nrow(x))

# Run Weighting -----------------------------------------------------------

svy_wt <- list()
for (i in names(svy)) {
    # filter: records with fish_avidity equal to missing or zero won't get weighted
    x <- svy[[i]]
    x <- x[x$fish_avidity != 0, ]
    
    # estimate weights for filtered rows & join back to all rows
    x <- est_wts(x, pop, i)
    x <- x[c("sguid", "rake_wt")]
    svy_wt[[i]] <- merge(svy[[i]], x, by = "sguid", all.x = TRUE)
}
svy_wt <- do.call(rbind, svy_wt) 

# save
write.csv(svy_wt, out_file, row.names = FALSE, na = "")
