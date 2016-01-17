library(shiny)
library(UsingR)
library(ggplot2)

shinyServer(
  function(input, output) {
    output$text1<- renderText({
      input$goButton
      suggest(input$text1)}) ##List of 1-5 predicted words based on data set
  }
)



  
