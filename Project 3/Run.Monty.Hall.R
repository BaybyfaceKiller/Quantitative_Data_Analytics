
# Description:
#  This script uses the functions in Monty.Hall.Utilities.R to run different
#    scenarios as the command line argument instructed

# Source the file "Monty.Hall.Utilities.R"
source("Monty.Hall.Utilities.R")
# Get the command line argument
args <- commandArgs(trailingOnly=TRUE)
# If the length of argument is not 1 then print out the error message and quit
if (length(args) != 1) {
  cat("Error: Number of arguments should be one.","\n")
  quit()
}
# If the argument is "Keep" then play 100 times without switching
if (args == "Keep") {
  fraction <- play.many.monty.halls(100,FALSE)
  # Print out the result
  cat("When the door is not switched, the fraction of wins is", fraction, "\n")
  # If the argument is "Switch" then play 100 times with switching
} else if (args == "Switch") {
  fraction <- play.many.monty.halls(100,TRUE)
  # Print out the result
  cat("When the door is switched, the fraction of wins is", fraction, "\n")
  # If the argument is not as expected print out the error message and quit
} else {
  cat('Error: Acceptable argument is "Keep" or "Switch".','\n')
  quit()
}
