library(shiny)
library(ggplot2)
library(dplyr)

dat <- read.csv("dat.csv")
dat$Join.Date <- as.Date(dat$Join.Date, format = "%m/%d/%Y")

shinyServer(function(input, output) {
        
        dataset <- reactive({dat[sample(nrow(dat), input$sampleSize), ]
        })  
        
        output$plot <- renderPlot({
                
                if (input$eu)
                        dataset <- reactive({dat[dat$EU=="EU", ]})
                
                p <- ggplot(dataset(), aes_string(x=input$x, y=input$y)) + geom_point()
                
                if (input$color != 'None')
                        p <- p + aes_string(color=input$color)
                
                facets <- paste(input$facet_row, '~', input$facet_col)
                if (facets != '. ~ .')
                        p <- p + facet_grid(facets)
                
                if (input$smooth)
                        p <- p + geom_smooth()
                
                if (input$jitter)
                        p <- p + geom_jitter()
                
                print(p)
                
        })
        
})