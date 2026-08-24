# Week 1 - Data Cleaning and Preliminary Analysis using R

# 1. Load the Titanic dataset
url <- "https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv"
data <- read.csv(url, stringsAsFactors = FALSE)

# 2. Understand the structure of the dataset
str(data)
summary(data)

# 3. Check the number of rows and columns
dim(data)

# 4. Check missing values
missing_values <- colSums(is.na(data))
print(missing_values)

# 5. Handle missing values
# Replace missing Age values with the median Age
data$Age[is.na(data$Age)] <- median(data$Age, na.rm = TRUE)

# Replace missing Embarked values with the most frequent value
mode_embarked <- names(sort(table(data$Embarked), decreasing = TRUE))[1]
data$Embarked[data$Embarked == ""] <- mode_embarked
data$Embarked[is.na(data$Embarked)] <- mode_embarked

# Cabin has many missing values, so create a new indicator
data$CabinKnown <- ifelse(is.na(data$Cabin) | data$Cabin == "", 0, 1)

# 6. Check missing values again
print(colSums(is.na(data)))

# 7. Outlier detection for Age and Fare
age_outliers <- boxplot.stats(data$Age)$out
fare_outliers <- boxplot.stats(data$Fare)$out

print("Age outliers:")
print(age_outliers)

print("Fare outliers:")
print(fare_outliers)

# 8. Normalization of Age and Fare
data$Age_Normalized <- (data$Age - min(data$Age)) /
                       (max(data$Age) - min(data$Age))

data$Fare_Normalized <- (data$Fare - min(data$Fare)) /
                        (max(data$Fare) - min(data$Fare))

# 9. Encode categorical variables
data$Sex_Encoded <- ifelse(data$Sex == "male", 1, 0)

data$Embarked_Encoded <- ifelse(data$Embarked == "S", 1,
                         ifelse(data$Embarked == "C", 2, 3))

# 10. Descriptive statistics
print("Summary statistics:")
print(summary(data))

# 11. Survival analysis
print("Survival count:")
print(table(data$Survived))

print("Survival by gender:")
print(table(data$Sex, data$Survived))

# 12. Correlation analysis
numeric_data <- data[, c("Survived", "Pclass", "Age", "SibSp",
                         "Parch", "Fare")]

correlation_matrix <- cor(numeric_data, use = "complete.obs")
print("Correlation matrix:")
print(correlation_matrix)

# 13. Visualizations

# Survival distribution
barplot(table(data$Survived),
        main = "Survival Distribution",
        xlab = "Survived (0 = No, 1 = Yes)",
        ylab = "Number of Passengers")

# Age distribution
hist(data$Age,
     main = "Age Distribution",
     xlab = "Age",
     ylab = "Frequency")

# Fare boxplot
boxplot(data$Fare,
        main = "Fare Outlier Detection",
        ylab = "Fare")

# Survival by gender
barplot(table(data$Sex, data$Survived),
        beside = TRUE,
        main = "Survival by Gender",
        xlab = "Gender",
        ylab = "Number of Passengers")

# 14. Create cleaned dataset
cleaned_data <- data[, c("PassengerId", "Survived", "Pclass",
                         "Sex", "Age", "SibSp", "Parch", "Fare",
                         "Embarked", "CabinKnown",
                         "Age_Normalized", "Fare_Normalized",
                         "Sex_Encoded", "Embarked_Encoded")]

# 15. Save cleaned dataset
write.csv(cleaned_data,
          "Titanic_Cleaned_Week1.csv",
          row.names = FALSE)

# Final structure
str(cleaned_data)
summary(cleaned_data)
