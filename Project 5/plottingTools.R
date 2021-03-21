
# Description:
#  This script contains functions that make scatter plot and box plot

# Create a function that reads the csv file into a dataframe
load_data <- function(file_name) {
  # Read the csv file into a dataframe
  data_df = read.csv(file_name)
  # Return the dataframe
  return(data_df)
}

# Create a function to make scatter plot
scatter_plot <- function(df) {
  # import libraries
  library(ggplot2)
  library(gridExtra)
  # create scatter scatter plot
  scatter<-ggplot(data=df,aes(x=Age,y=Strength))+geom_point(aes(color=Cement))+
                  labs(x="Age(Days)",y="Strength(MPa)",color="Cement(kg)")

  # create density plot for Age
  age_density <- ggplot(data=df,aes(Age))+geom_density(alpha=0.5,fill='blue')+
                 labs(x='Age(Days)',y='density')

  # create density plot for Strength
  strength_density <- ggplot(data=df,aes(Strength))+geom_density(alpha=0.5,
                      fill='red')+labs(x='Strength(MPa)',y='density')+coord_flip()
  # create a blank placeholder plot
  blank_plot <- ggplot()+geom_blank(aes(1,1))+theme(plot.background=element_blank(),
                 panel.grid.major=element_blank(),panel.grid.minor=element_blank(),
                 panel.border=element_blank(),panel.background=element_blank(),
                 axis.title.x = element_blank(),axis.title.y = element_blank(),
                 axis.text.x = element_blank(),axis.text.y = element_blank(),
                 axis.ticks = element_blank())
  # plot the scatter plot and two density plots on the blank plot
  grid.arrange(age_density, blank_plot, scatter, strength_density, ncol=2,
               nrow=2, widths=c(5, 3), heights=c(2, 5))
}

# create a function to make box plot
box_plot <- function(df) {
  # import libraries
  library(ggplot2)
  library(ggpubr)
  # extract the independent variable Age
  ind_var <- df[,c('Age')]
  # create bins for the continuous variable
  bin=cut_width(ind_var,width=30,boundary=0)
  # create boxplot using the created bins
  ggplot(data=df,aes(x=bin,y=Strength))+geom_boxplot(aes(fill='#FF9999'),
         show.legend=FALSE)+labs(x='Age(Days)',y='Strength(MPa)')+geom_hline(
         yintercept=mean(df$Strength),linetype=2)+stat_compare_means()
}
