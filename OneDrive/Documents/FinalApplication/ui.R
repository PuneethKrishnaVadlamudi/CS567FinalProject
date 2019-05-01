#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predict apporval percentage from Apporval Polllist"),
  
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
       textOutput("pred1")

       
    )
  )
))
