
# Description:
#  This script  (1) Finds total number of service calls per city division
              # (2) Finds number of reports of dead animal on expressway
              # (3) Finds the ward with the most 311 calls in September


# Part a.
# Receive file path arguments from the command line
args <- commandArgs(trailingOnly = TRUE)
# Create file path
# file_path <- paste("./",args,sep='')
# Put data of corresponding file into a dataframe
file_data <- read.csv(args)
# Part b.
# Print which file is being processed
cat('Processing data from file:',args,sep='',"\n")
# Part c.
# Find different divisions in dataframe
divisions <- unique(file_data$Division)
cat("Total number of service calls per city division:","\n")
# Loop over divisions to find number of service calls and print result
for (division in divisions) {
  num_of_calls <- nrow(file_data[file_data$Division==division,])
  # Print result
  cat(" ",division,'-',num_of_calls,'\n')
}
# Part d.
# Find number of service calls about dead animals on expressway
num_of_dead_animal_calls <- nrow(file_data[file_data$Service.Request.Type==
                                 'Dead Animal On Expressway',])
# Print result
cat('Total number of reports of a dead animal on an expressway is',
     num_of_dead_animal_calls,'\n')
# Part e.
# Slice the dataframe with divsion 311
division_311_data <- file_data[file_data$Division=='311',]
# Slice division_311_data with month=September
sept_division_311_data <- division_311_data[substr(division_311_data$Creation.Date,
                                                    6,7)=='09',]
# Create a frequency table on ward
frequency_table <- table(sept_division_311_data$Ward)
# Find most frequency ward
most_calls_ward <- names(sort(frequency_table,decreasing=TRUE)[1])
cat('The ward with the most 311 calls in September was',most_calls_ward,'\n')
