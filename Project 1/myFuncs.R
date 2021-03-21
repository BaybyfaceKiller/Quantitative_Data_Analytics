
# Description:
#  This script contains functions that calculate
#    geometric mean of postive elements in vector and arithmetic mean
#    of negative elements in vector

# (1a) Function that calculates geometric mean of postive values in vector
geom.pos.mean <- function(x) {
  pos_values <- x[x>0] # Find positive values in x
  g_mean <- prod(pos_values)^(1/length(pos_values)) # Calcualte geometric mean
  return(g_mean)
}

# (1b) Function that calculates arithmetic mean of negative values in vector
neg.mean <- function(x) {
  neg_values <- x[x<0] # Find negative values in x
  a_mean <- sum(neg_values)/length(neg_values) # Calcualte arithmetic a_mean
  return(a_mean)
}
