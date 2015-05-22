library(shiny)
library(ggplot2)

dataset <- dat

shinyUI(fluidPage(
        
        title = "PDA Explorer",
        
        plotOutput('plot'),
        
        hr(),
        
        fluidRow(
                column(3,
                       h4("PDA Explorer"),
                       dateRangeInput(inputId = 'joindate', 
                                      label = 'Join Date',
                                      start = "2014-1-1"),
                       br(),
                       checkboxInput('eu', 'EU'),
                       checkboxInput('smooth', 'Smooth'),
                       checkboxInput('jitter', 'Jitter',value = TRUE)
                ),
                column(4, offset = 1,
                       selectInput('x', 'X', names(dataset),"Member.Type"),
                       selectInput('y', 'Y', names(dataset), "Order.Total"),
                       selectInput('color', 'Color', c('None', names(dataset)))
                ),
                column(4,
                       selectInput('facet_row', 'Facet Row',
                                   c(None='.', names(dat[sapply(dat, is.factor)]))),
                       selectInput('facet_col', 'Facet Column',
                                   c(None='.', names(dat[sapply(dat, is.factor)])))
                )
        )
))