shinyServer(
  function(input, output) {
    output$text1<- renderText({
      suggest(input$text1)}) ##List of 1-5 predicted words based on data set
  }
)