library(shiny)
library(ggplot2)

dataset <- read.csv("dat.csv")
dat <- read.csv("dat.csv")

shinyUI(navbarPage(title = "Navbar",collapsible = TRUE,fluid = TRUE,inverse = F,
        tabPanel("PDA Explorer",
                 fluidPage(
        
        title = "PDA Explorer",
        
        plotOutput('plot'),
        
        hr(),
        
        fluidRow(
                column(3,
                       h4("PDA Explorer"),
                       sliderInput('sampleSize', 'Sample Size', 
                                   min=1, max=5000,
                                   value=min(400, nrow(dataset)), 
                                   step=50, round=0),
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
)),      tabPanel("About This Application",
                 includeHTML("about.html")
                 )                              
))
