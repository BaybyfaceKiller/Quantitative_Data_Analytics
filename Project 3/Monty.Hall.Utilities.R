
# Description:
#  This script contains functions that help to investigate
#    Monty Hall Problem

# (1a)
# Create a function that can pick a random door number
pick.door <- function() {
  # Pick one number each time from 1,2,3
  picked_door_number <- sample(c(1,2,3),size=1)
  # Return the picked number
  return(picked_door_number)
}
# (1b)
# Create a function that will return the number of the door which Monty Hall
# will open before the contestant
opened.door <- function(door_number_with_car, door_number_chosen) {
  door_numbers <- c(1,2,3)
  not_available_door_numbers <- c(door_number_with_car,door_number_chosen)
  # Exclude the door numbers that are not available to choose
  available_door_numbers <- door_numbers[! door_numbers %in%
                                      not_available_door_numbers]
  # If only one number to choose then just return that number
  if (length(available_door_numbers)==1) {
    opened_door_number <- available_door_numbers
  # Else randomly sample from the available numbers
  } else {
    opened_door_number <- sample(available_door_numbers,size=1)
  }
  # Return the door number to open
  return(opened_door_number)
}
# (1c)
# Create a function that will play the game and behave as the given argument
# indicated
play.monty.hall <- function(switch_door) {
  door_numbers <- c(1,2,3)
  # Randomly pick a door number with car
  picked_car_number <- pick.door()
  # Randomly pick a door number that the contestant selected
  picked_selected_number <- pick.door()
  # Randomly pick a door to open
  picked_opened_door_number <- opened.door(picked_car_number, picked_selected_number)
  # Doors that has been opened and door has been selected can't be the option to change to
  not_change_option_numbers <- c(picked_selected_number, picked_opened_door_number)
  # If the argument is TRUE then change the selected door number
  # Since the opened door and the chosen door cannot be the same 
  # There is only one number left to change to
  if (switch_door == TRUE) {
    picked_selected_number <- door_numbers[! door_numbers %in%
                                           not_change_option_numbers]
  }
  # Check if the contestant won the car
  game_result <- picked_selected_number == picked_car_number
  # Return the game result
  return(game_result)
}
# (1d)
# Create a function that plays the game n times as the given argument instructed
play.many.monty.halls <- function(n,with_switch_door) {
  # Start to count the winning game from 0
  counter <- 0
  # Repeat the game n times
  for (i in 1:n) {
    won_car <- play.monty.hall(with_switch_door)
    # If won the car, add the counter by 1
    if (won_car == TRUE) {
      counter <- counter+1
    }
  }
  # Calculate the fraction of games that won the car
  fraction_of_winning <- counter/n
  # Return the fraction of winning
  return(fraction_of_winning)
}
