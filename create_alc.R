# Laura Pietikäinen 21.11.2022. Data was sourced from IDOS cource materials and it originates to UCI Machine Learning Repository. 
# Data consists of questionnaires about alcohol consumption of secondary school students in Portugal. Excerise set 3 has been used as a
# source for obtaining the codes. 

# read the data and explore the structure

getwd()
setwd("/home/local/pielaura/Documents/zasemaemulaattori/Documents/kurssit/Introduction_to_open_data_science/excerices_1/IODS-project/data")
student_por <- read.csv("student-por.csv", sep = ";")
head(student_por)
student_mat <- read.csv("student-mat.csv", sep = ";")
head(student_mat)
dim(student_mat)
dim(student_por)
str(student_mat)
str(student_por)


# Join the two data sets using all other variables than "failures", "paid", "absences", "G1", "G2", "G3" as (student) identifiers. 
# Keep only the students present in both data sets. Explore the structure and dimensions of the joined data. (1 point)

library(dplyr)

# columns that differ between datasets. 
free_cols <- c("failures", "paid", "absences", "G1", "G2", "G3")

# the rest of the columns can be used as identifiers. 
join_cols <- setdiff(colnames(student_por), free_cols)
join_cols

# join the two data sets by the selected identifiers
math_por <- inner_join(student_mat, student_por, by = join_cols)

# column names of the new dataset
colnames(math_por)

# how does the new data set look like
summary(math_por)
str(math_por)
structure(math_por)
dim(math_por)

# Get rid of the duplicate records in the joined data set. Either a) copy the solution from the exercise "3.3 The if-else structure"
# to combine the 'duplicated' answers in the joined data, or b) write your own solution to achieve this task. (1 point)

# column names
colnames(math_por)

# include only the joined columns to a new data frame. 
alc <- select(math_por, all_of(join_cols))

# print out the differing columns. 
free_cols

# for every column name not used for joining...
for(col_name in free_cols) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(math_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- "change me, don't mind this!"
  }
}

# glimpse at the new combined data
glimpse(alc)
dim(alc)

# Take the average of the answers related to weekday and weekend alcohol consumption to create a new column 'alc_use' to the joined data.
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc$alc_use
# Then use 'alc_use' to create a new logical column 'high_use' which is TRUE for students for which 'alc_use' is greater than 2 (and FALSE otherwise). (1 point)
alc <- mutate(alc, high_use = alc_use > 2)
alc$high_use

#Glimpse at the joined and modified data to make sure everything is in order. The joined data should now have 370 observations.
glimpse(alc)
dim(alc)

#Save the joined and modified data set to the ‘data’ folder, using for example write_csv() function (readr package, part of tidyverse). (1 point)
getwd()
write_csv(alc, "alc.csv")
?write_csv
