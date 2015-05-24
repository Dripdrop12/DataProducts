setwd("C:/Users/Jon/Desktop/JHU Data Specialization/Developing Data Products/DataProducts")

runApp("app1", display.mode = "showcase")

library(shiny)
library(ggplot2)
library(dplyr)

# Downlad merged data from merge.R #
dat <- read.csv("dat.csv")


# Update the about.html file #
setwd("C:/Users/Jon/Desktop/JHU Data Specialization/Developing Data Products/DataProducts/app1")
render("about.Rmd", html_document())


 