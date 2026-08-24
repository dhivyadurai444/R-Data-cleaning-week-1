# Week 4 - Comprehensive Data Analysis Reporting and Presentation

library(ggplot2)

# Load Titanic dataset
titanic <- read.csv("https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv")

# View dataset
head(titanic)

# Dataset structure
str(titanic)

# Summary of the dataset
summary(titanic)

# Check missing values
colSums(is.na(titanic))

# Basic visualization
ggplot(titanic, aes(x = factor(Survived))) +
  geom_bar() +
  labs(
    title = "Titanic Survival Distribution",
    x = "Survival Status",
    y = "Number of Passengers"
  )

# Survival by gender
ggplot(titanic, aes(x = Sex, fill = factor(Survived))) +
  geom_bar() +
  labs(
    title = "Titanic Survival by Gender",
    x = "Gender",
    fill = "Survived"
  )
