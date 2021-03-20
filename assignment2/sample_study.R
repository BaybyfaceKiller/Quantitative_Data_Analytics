# Name: Chenxu Liu
# SciNet username: tmp_cliu
# Description:
#  This script finds total number of patients born in 1991 and print their information

years <- c(1993, 1999, 1993, 1995, 1991, 1991, 1996, 1991,
    1997, 1998, 1999, 1994, 1997, 1997, 1992, 1998, 1994,
    1996, 1999, 1992, 1995, 1994, 1991, 1998, 1998)

months <- c(9, 2, 1, 6, 1, 9, 9, 7, 2, 1, 10, 5, 2, 10,
    12, 8, 1, 11, 2, 11, 2, 1, 4, 1, 3)

ci.types <- c(20, 22, 11, 15, 19, 15, 17, 24, 6, 19, 19,
    15, 6, 2, 22, 21, 24, 4, 3, 2, 8, 24, 5, 19, 18)

volumes <- c(8, 6, 3, 7, 4, 5, 3, 6, 6, 7, 5, 3, 6, 4, 5,
    3, 5, 4, 4, 5, 7, 4, 4, 6, 6)

students <- c("Bert", "Bert", "Bert", "Bert", "Bert",
    "Frank_Richard", "Frank_Richard", "Frank_Richard", "Frank_Richard", "Frank_Richard",
    "Lawrence", "Lawrence", "Lawrence", "Lawrence", "Lawrence",
    "THOMAS", "THOMAS", "THOMAS", "THOMAS", "THOMAS",
    "alexander", "alexander", "alexander", "alexander", "alexander")

# (1) Create a dataframe containing vectors above
mystudy <- data.frame(years,months,ci.types,volumes,students)

# (2) Rename columns of the dataframe
colnames(mystudy) <- c("Year.of.birth","Month.of.birth","CI.type","Volume","Student")

# (3) Create a new variable and assign value to it
search.year <- 1991

# (4) Perform conditional slicing and display it
born.in.year <- mystudy[mystudy$Year.of.birth == search.year,]
cat("Patients born in 1991","\n")
cat("---------------------------------","\n")
print(born.in.year)
cat("---------------------------------","\n")

# (5) Display total number of patients born in 1991
year_count <- nrow(born.in.year)
cat("Total number of patients born in 1991 is",year_count,"\n")
