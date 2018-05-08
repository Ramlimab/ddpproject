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
  titlePanel("Predicting Red Wine Quality using Machine Learning"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
        h4('Select wine properties'),
        
       sliderInput('alcohol',
                   "Alcohol:",
                   min = 8.5,
                   max = 15,
                   value = 10,step=0.25),
       sliderInput("sulphates",
                   "Sulphates",
                   min = 0.35,
                   max = 2.0,
                   value = 0.7,step=0.05),
       sliderInput("total.sulfur.dioxide",
                   "Total Sulphur Dioxide",
                   min = 6,
                   max = 150,
                   value = 45),
       sliderInput("volatile.acidity",
                   "Volatile Acidity:",
                   min = 0.2,
                   max = 1.6,
                   value = 0.5,step=0.1),
       sliderInput("density",
                   "Density",
                   min = 0.991,
                   max = 1.0,
                   value = 0.997,step=0.001),
       h3('Wine Quality Prediction:'),
       h2(textOutput('quality'),style='color:red')
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput('plot1'),
       plotOutput('plot2'),
       plotOutput('plot3')
    )
  )
))
