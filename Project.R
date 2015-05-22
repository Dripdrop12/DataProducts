setwd("C:/Users/PDAUSER/Desktop/Data Products")

library(shiny)
library(ggplot2)
library(dplyr)

# Downlad merged data from merge.R #
dat <- read.csv("dat.csv")

runApp("app1", display.mode = "showcase")




[dat$Join.Date %in% seq.Date(
        from = input$Join.Date[1], to = input$Join.Date[2], by ="days"), ] 