# Week 3 - Statistical Analysis and Predictive Modeling using R

library(ggplot2)

# Load Titanic dataset
titanic <- read.csv("https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv")

# View dataset
head(titanic)

# Dataset structure
str(titanic)

# Summary statistics
summary(titanic)
