# Name: Chenxu Liu
# SciNet username: tmp_cliu
# Description:
#  This script is used to perform calculations using
#   functions in myFuncs.R

# Create vetor x
x <- c(-10, -3, 2, 4, 5, 0.3, -0.1, 2.1, 3.2, -12.1, -1.2)
# Read argument from the command line
args <- commandArgs(trailingOnly=TRUE)
source("myFuncs.R")
if (args == 0) {
  result <- neg.mean(x) # Calcualte arithmetic mean if args is 0
  cat("The mean of the negative values in the data is",result,"\n")
} else if (args == 1) {
    result <- geom.pos.mean(x) # Calcualte geometric mean if args is 1
    cat("The geometric mean of the positive values in the data is",result,"\n")
} else cat("Error, incorrect command line argument.") # Print error message otherwise
