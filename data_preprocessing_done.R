# Data Preprocessing

#1 Importing the dataset
dataset = read.csv('Data.csv')

#2 Taking care of missing data
dataset$Age = ifelse(is.na(dataset$Age),
                     ave(dataset$Age, FUN = function(x) mean(x, na.rm = TRUE)),
                     dataset$Age)
dataset$Salary = ifelse(is.na(dataset$Salary),
                        ave(dataset$Salary, FUN = function(x) mean(x, na.rm = TRUE)),
                        dataset$Salary)

#3 Encodering categorical data
dataset$Country = factor(dataset$Country,
                         levels = c('France', 'Spain', 'Germany'),
                         labels = c(1,2,3))
dataset$Purchased = factor(dataset$Purchased,
                           levels = c('No','Yes'),
                           labels = c(0,1))

#4 Splitting the dataset into Training set and Test set
#import caTools
library(caTools)
set.seed(123)
split = sample.split(dataset$Purchased, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set= subset(dataset, split == FALSE)


#5 Feature Scaling
#note country and purchased are not numeric they are factors (i.e. we used factor to encode categorical data previously)
#so we have to exclude the two fields from scaling
training_set[, 2:3] = scale(training_set[,2:3])
test_set[,2:3] = scale(test_set[,2:3])
