
# Description:
#  This script generates plots according to the commandline argument using
#    functions in plottingTools.R


# The data used to make plots is the age of the concrete in days and the strength
#   of the concrete in MPa, the main purpose is to analyze if concrete with
#   greater age will have less strength. The scatter plot is made of three parts:
#   the scatter plot of Strength vs. Age, the density distribution of Age and
#   the density distributio of Strength. Also, the color of the points in the
#   scatter plot is related to the amount of cement used to build the concrete.
#   These three plots are plotted on a blank plot to generate one single plot.
#   Since the Age is a continuous variable, it was split into several boxes
#   to generate the box plot. The dotted line indicates the average concrete
#   strength in the dataset, the p-value of Kruskal test is
#   shown on the left corner.

# source utilities file
source('plottingTools.R')
# receive commandline argument
args <- commandArgs(trailingOnly=TRUE)
# if the length of commandline argument is not 1
if (length(args) != 1) {
  # print error message
  cat("Accepted arguments: 'scatter' or 'box'.","\n")
  # quit
  quit()
}

# if the commandline argument is 'scatter'
if (args=='scatter') {
  # load the data
  my_data=load_data('concrete_data.csv')
  # create pdf to store the plot
  pdf('scatter_plot.pdf')
  # make scatter plot
  scatter_plot(my_data)
  # if the commandline argument is 'box'
} else if (args=='box') {
  # load the data
  my_data=load_data('concrete_data.csv')
  # create pdf to store the plot
  pdf('box_plot.pdf')
  # make box plot
  box_plot(my_data)
  # else print error message and quit
} else {
  cat("Accepted arguments: 'scatter' or 'box'.","\n")
  quit()
}
