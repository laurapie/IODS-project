# Laura Pietikäinen 14.11.2022
# This is the second set of exerices for the IDOS course. The data was obtained from the course materials and has been provided by
# Kimmo Vehkalahti. 

library("tidyverse")

# 1. Read and explore the data
# read the data
data1 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
# explore the structure
dim(data1)
# 183 observations in 60 variables. 
structure(data1)
str(data1)
# data consists mostly of integers except the variable gender. 

# Create an analysis dataset with the variables gender, age, attitude, deep, stra, surf and points by combining questions in the 
# learning2014 data, as defined in the Exercise Set and also on the bottom part of the following page (only the top part of the page
# (by taking the mean). Exclude observations where the exam points variable is zero. (The data should then have 166 observations and 7 
# variables) (1 point)

# wanted variables: gender, age, attitude, deep, stra, surf and points

# attitude is a combination of 10 variables, it should be divided by 10. 
data1$attitude <- data1$Attitude / 10
data1$attitude

# questions related to deep, surface and strategic learning -> deep stra ad surf.
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning 
deep_columns <- select(data1, one_of(deep_questions))
# and create column 'deep' by averaging
data1$deep <- rowMeans(deep_columns)

# surface learning
surface_columns <- select(data1, one_of(surface_questions))
data1$surf <- rowMeans(surface_columns)

# strategic learning
strategic_columns <- select(data1, one_of(strategic_questions))
data1$stra <- rowMeans(strategic_columns)

# columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
data2 <- select(data1, one_of(keep_columns))

# see the structure of the new dataset
str(data2)
dim(data2)

# now remove the instances in which points are 0. 
data2 <- filter(data2, Points > 0)
dim(data2)

# I will change Points to points
colnames(data2)
colnames(data2)[7] <- "points"
colnames(data2)[2] <- "age"

# set the working directory
getwd()
setwd("/home/local/pielaura/Documents/zasemaemulaattori/Documents/kurssit/Introduction_to_open_data_science/excerices_1/IODS-project")
# wd was already correct

# write the data to the data folder 
data2
write.csv(data2,"/home/local/pielaura/Documents/zasemaemulaattori/Documents/kurssit/Introduction_to_open_data_science/excerices_1/IODS-project/data/data2.csv", row.names = FALSE)
setwd("/home/local/pielaura/Documents/zasemaemulaattori/Documents/kurssit/Introduction_to_open_data_science/excerices_1/IODS-project/data")
getwd()
list.files()
data3 <- read_csv("data2.csv")
head(data3)
dim(data3)

# then, push to Github