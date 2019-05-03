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
 output$Data <- renderText({
   "
 This data(source code) is from https://github.com/fivethirtyeight/data/tree/master/trump-approval-ratings
 The data is all about polls taken by different pollster at different time intervals about president trump goverenances and it tells
 approval percentage for that poll since earliest day of the poll started to the end of that poll(daysSincefirstpoll) and sample size 
 is the number of people that polled. Sample size differs according to the poll and  pollster taken. 

 The question we worked on - Are the polls Baised (depending on the pollster??) and how does it effect on approval percentage means 
 does it increase or decrease for different polls by different pollster ?

 Seeing the summary of the best model we can get approvalPercentage = .04 + .000001 * daysSinceFirstPoll - 0.0000004 * samplesize
 from that Coefficients value (formula above)it is clear that number of dayssincefirstpoll increases then there is slightly growth in 
 approvalPercentage and sample size increases then percentage goes down slightly. We have selected pollster has Gallup and observed the 
 result of apporval precentage residual plot and its Predicted apporval percentage for it." 
 })  
  
   
    })
