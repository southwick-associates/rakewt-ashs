# functions

# Estimate rake weights for input survey data & population distributions
# 
# This is basically a wrapper for anesrake(). It prints a summary and
# returns the survey dataset with a rake_wt variable appended.
# 
# - svy  survey data frame
# - pop  population distribution list
# - print_name  header to print in summary (useful for log output)
# - sguid  name of varible that holds unique id
est_wts <- function(
    svy, pop, print_name = "", idvar = "sguid"
) {
    # run weighting
    wts <- anesrake(pop, svy, caseid = svy[[idvar]], force1 = TRUE, cap = 100)
    
    # print summary
    cat("\nWeight Summary for", print_name, "-----------------------------\n\n")
    print(summary(wts))
    
    # return output
    svy$rake_wt <- wts$weightvec
    svy
}
