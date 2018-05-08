#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(caret)
library(ggplot2)

set.seed(435)

buildrandrow<-function(winedata,input1,input2,input3,input4,input5){
    randrow<-winedata[sample(nrow(winedata),1),]
    randrow$alcohol<-input1
    randrow$sulphates<-input2
    randrow$total.sulfur.dioxide<-input3
    randrow$volatile.acidity<-input4
    randrow$density<-input5
    return(randrow)
}

# Define server logic required to draw a plot
shinyServer(function(input, output) {
    
    color='red'
    folder<-'D:\\Personal and admin\\Courses\\Data Science Spec\\9. Developing Data Products\\Course Project'
    datafilename<-paste(folder,'\\dataset\\winequality-',color,'2.csv',sep='')
    winedata<-read.csv(datafilename)
    MLmodel<-readRDS(paste(folder,'\\',color,'winemodel.rds',sep=''))
    
    output$quality<-renderText({
        randrow<-winedata[sample(nrow(winedata),1),]
        randrow$alcohol<-input$alcohol
        randrow$sulphates<-input$sulphates
        randrow$total.sulfur.dioxide<-input$total.sulfur.dioxide
        randrow$volatile.acidity<-input$volatile.acidity
        randrow$density<-input$density
        MLpred<-predict(MLmodel,randrow)
        MLpred<-as.character(MLpred)
        return(MLpred)
    })
    
    output$plot1<-renderPlot({
        randrow<-winedata[sample(nrow(winedata),1),]
        randrow$alcohol<-input$alcohol
        randrow$sulphates<-input$sulphates
        p<-ggplot(data=winedata,aes(alcohol,sulphates))
        p<-p+geom_point(aes(colour=quality))
        p<-p+geom_point(data=randrow,aes(alcohol,sulphates),colour='red',size=7)
        p
    })
    
    output$plot2<-renderPlot({
        randrow<-winedata[sample(nrow(winedata),1),]
        randrow$alcohol<-input$alcohol
        randrow$total.sulfur.dioxide<-input$total.sulfur.dioxide
        p2<-ggplot(data=winedata,aes(alcohol,total.sulfur.dioxide))
        p2<-p2+geom_point(aes(colour=quality))
        p2<-p2+geom_point(data=randrow,aes(alcohol,total.sulfur.dioxide),colour='red',size=7)
        p2
    })
    
    output$plot3<-renderPlot({
        randrow<-winedata[sample(nrow(winedata),1),]
        randrow$alcohol<-input$alcohol
        randrow$volatile.acidity<-input$volatile.acidity
        p<-ggplot(data=winedata,aes(alcohol,volatile.acidity))
        p<-p+geom_point(aes(colour=quality))
        p<-p+geom_point(data=randrow,aes(alcohol,volatile.acidity),colour='red',size=7)
        p
    })
})
