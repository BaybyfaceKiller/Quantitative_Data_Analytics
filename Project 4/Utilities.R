
# Description:
#  This script contains utility functions that perform actions on the
#     dataset

# Create a function that reads the csv file into a dataframe
load_data <- function(file_name) {
  # Read the csv file into a dataframe
  data_df = read.csv(file_name)
  # Return the dataframe
  return(data_df)
}

# Create a function that calculates correlation indicators
correlation_indicator <- function(df,exp_var,resp_var) {
  cat("----------","\n")
  cat("Computing correlation indicators...","\n")
  # Calculate covariance of two variables
  covariance <- var(df[,c(exp_var)],df[,c(resp_var)])
  # Calcualte correlation of two variables
  correlation <- cor(df[,c(exp_var)],df[,c(resp_var)])
  # Print the covariance
  cat("Covariance:",covariance,"\n")
  # Print the correlation
  cat("Correlation coefficient:",correlation,"\n")
  # Return the result as a vector
  return(c(covariance,correlation))
}

# Create a function that implements linear model
linear_model <- function(df,exp_var,resp_var) {
  cat("----------","\n")
  cat("Fitting a Linear Model","\n")
  # Fit linear model
  model <- lm(df[,c(resp_var)] ~ df[,c(exp_var)])
  # Print model summary
  print(summary(model))
  cat("----------","\n")
  return(model)
}

# Create a function that implements quadratic model
quadratic_model <- function(df,exp_var,resp_var) {
  cat("----------","\n")
  cat("Fitting a Quadratic Model","\n")
  # Create the square of explanatory variable
  exp_var2 <- df[,c(exp_var)]**2
  # Fit quadratic model
  model <- lm(df[,c(resp_var)] ~ df[,c(exp_var)]+exp_var2)
  # Print model summary
  print(summary(model))
  cat("----------","\n")
  return(model)
}

# Create a function that implements generalized linear model
generalized_linear_model <- function(df,exp_var,resp_var) {
  cat("----------","\n")
  cat("Fitting a Generalized Linear Model","\n")
  # Extract explanatory data
  exp_data <- df[,c(exp_var)]
  # Extract response data
  resp_data <- df[,c(resp_var)]
  # Fit generalized linear model
  model <- glm(resp_data ~ exp_data,family=poisson(link='log'))
  # Print model summary
  print(summary(model))
  cat("----------","\n")
  return(model)
}

# Create a function that generates plot
plot_function <- function(df,exp_var,resp_var,fitted_model,model_num) {
  # If the model is quadratic
  if (model_num == 2) {
    # Plot datapoints
    plot(df[,c(exp_var)],df[,c(resp_var)],xlab='Temperature',ylab='Count')
    # Create a sequence of number in the same range of explanatory variable
    xx <- seq(min(df[,c(exp_var)]), max(df[,c(exp_var)]),len = 100)
    # Calculate the predicted value using the coefficents in the model
    yy <- fitted_model$coef %*% rbind(1, xx, xx*xx)
    # Plot the line representing the model
    lines(xx, yy)
    # If the model is linear
  } else if (model_num == 1) {
    # Plot datapoints
    plot(df[,c(exp_var)],df[,c(resp_var)],xlab='Temperature',ylab='Count')
    # Create a sequence of number in the same range of explanatory variable
    xx <- seq(min(df[,c(exp_var)]), max(df[,c(exp_var)]),len = 100)
    # Calcualte the predicted value using the coefficents in the model
    yy <- fitted_model$coef %*% rbind(1, xx)
    # Plot the line representing the model
    lines(xx, yy)
    # If the model is generalized linear
  } else if (model_num == 3) {
    # Plot datapoints
    plot(df[,c(exp_var)],df[,c(resp_var)],xlab='Temperature',ylab='Count')
    # Creat sorted explanatory variable
    sorted_var <- sort(df[,c(exp_var)])
    # Plot the line representing the model
    lines(sorted_var,predict(fitted_model,data.frame(exp_data=sorted_var),type='response'))
  }
}
