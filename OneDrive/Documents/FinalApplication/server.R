#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)


shinyServer(function(input, output) {
   model1 <- lm(approvalPercentage ~ daysSinceFirstPoll+ samplesize+ factor(pollster), data = J) # data J is from finalproject1.rmd
  
  model1pred <- reactive({
    daysInput <- input$SliderDays
    sampleInput <- input$Slidersample
   
    
    predict(model1, newdata = data.frame(daysSinceFirstPoll = daysInput,
                                         samplesize = sampleInput,
                                         pollster = 'Gallup'
                                        ))
    })
  
  days <- reactive({
    daysInput <- input$SliderDays
  })
    
  output$plot1 <- renderPlot(
    
    ggplot(J, aes(x = daysSinceFirstPoll, y = residuals)) +
      geom_point(colour = "black")  +
      geom_segment(aes(xend = daysSinceFirstPoll, yend = 0), alpha = .01) + geom_hline(yintercept = 0) 
    + geom_point(aes(x=days(), y = 0), colour = "red")

     )
  
 output$pred1 <- renderText({
        model1pred()
  })    
  
  
   
    })
