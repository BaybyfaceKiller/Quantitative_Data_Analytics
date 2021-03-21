
# Description:
#  This script performs actions on the dataset using functions in the
#     utility file based on given argument

# Comment on observation of the result:
#         (1) The result from linear model shows temperature has strong
#             correlation with the number of bikes used
#         (2) The result from quadratic model shows by adding the quadratic
#             term to the model, the R-square improved and residual standard
#             error decreased
#         (3) Since the dependent variables are counts which are discrete numbers,
#             I used poisson as error family and log as link, the plot shows
#             generalized linear model is a better fit than quadratic model and
#             the residual also dropped significantly

# Source the utility file
source('Utilities.R')
# Get the argument from commandline
args <- commandArgs(trailingOnly=TRUE)
# Check if the length of commandline argument is 1
if (length(args) != 1) {
  cat("Error: This scripts requires only one argument: 1, 2 or 3","\n")
  quit()
}
# If the commandline argument is 1
if (args == 1) {
  # Load the dataset
  my_data <- load_data('day.csv')
  # Calcualte correlation indicator between two specified variables
  cor_ind=correlation_indicator(my_data,'temp','cnt')
  # Fit a linear model with the data using specified variables
  my_model <- linear_model(my_data,'temp','cnt')
  # Plot the datapoints and the line for the model
  plot_function(my_data,'temp','cnt',my_model,1)
  # If the commandline argument is 2
} else if (args == 2) {
  # Load the dataset
  my_data <- load_data('day.csv')
  # Calcualte correlation indicator between two specified variables
  cor_ind=correlation_indicator(my_data,'temp','cnt')
  # Fit a quadratic model with the data using specified variables
  my_model <- quadratic_model(my_data,'temp','cnt')
  # Plot the datapoints and the line for the model
  plot_function(my_data,'temp','cnt',my_model,2)
  # If the commandline argument is 3
} else if (args == 3) {
  # Load the dataset
  my_data <- load_data('day.csv')
  # Calcualte the correlation indicator between two specified variables
  cor_ind=correlation_indicator(my_data,'temp','cnt')
  # Fit a generalized linear model with the data using specified variables
  my_model <- generalized_linear_model(my_data,'temp','cnt')
  # Plot the datapoints and the line for the model
  plot_function(my_data,'temp','cnt',my_model,3)
  # If the commandline argument is not as expected
} else {
  # Print the error message and quit
  cat("Error: This scripts requires only one argument: 1, 2 or 3 ","\n")
  quit()
}
