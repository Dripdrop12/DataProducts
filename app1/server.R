library(shiny)
library(ggplot2)
library(dplyr)

dat <- read.csv("dat.csv")

shinyServer(function(input, output) {
        
        
        dataset <- reactive({
                # Variable names for input values #
                isEU <- input$eu
                minJoin <- input$joindate[1]
                maxJoin <- input$joindate[2]
                dat %>% select(everything()) %>%
                        filter(Join.Date >= minJoin,
                               Join.Date <= maxJoin)
                dat <- as.data.frame(dat)
        })      
        
        output$plot <- renderPlot({
                                
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