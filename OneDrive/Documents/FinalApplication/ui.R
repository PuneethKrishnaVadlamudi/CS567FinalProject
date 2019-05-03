#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# This data(source code) is from " https://github.com/fivethirtyeight/data/tree/master/trump-approval-ratings "

# The data is all about polls taken by different pollster at different time intervals about president trump goverenances and it tells
# approval percentage for that poll since earliest day of the poll started to the end of that poll(daysSincefirstpoll) and sample size 
# is the number of people that polled. Sample size differs according to the poll and  pollster taken. 

# The question we worked on - Are the polls Baised (depending on the pollster??) and how does it effect on approval percentage means 
# does it increase or decrease for different polls by different pollster ?

# Seeing the summary of the best model we can get approvalPercentage = .04 + .000001 * daysSinceFirstPoll - 0.0000004 * samplesize
# from that Coefficients value (formula above)it is clear that number of dayssincefirstpoll increases then there is slightly growth in 
# approvalPercentage and sample size increases then percentage goes down slightly. We have selected pollster has Gallup and observed the 
# result of apporval precentage residual plot and its Predicted apporval percentage for it.

# 

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Residual plot of apporval percentage and daysssincefirstpoll from Apporval Polllist"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("SliderDays","how many days",0,1000, value = 10),
      sliderInput("Slidersample","what is samplesize",0,55000, value = 10),
      
      checkboxInput("showModel1", "Show/Hide Model1", value = TRUE)
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("plot1"),
       h3("Predicted apporval percentage from Model 1 :"),
       textOutput("pred1"),
       h3("Information About Data :"),
       textOutput("Data")
       
       
    )
  )
))
