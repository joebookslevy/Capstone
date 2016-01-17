shinyUI(fluidPage(
  headerPanel("Text Prediction"),
  sidebarPanel(
   textInput("text1", label="Enter two words"),
   actionButton("gobutton","Submit") 
   ),
  mainPanel(
    h5('This application is built to demonstrate a text prediction algorithm. 
        The algorithm is based off of a sample of US news, blogs, and twitter 
        content. Enter two words (of a phrase, beginning of a sentence, etc.) 
        and the algorithm will return the top 1-3 predicted next words based on 
        your entry compared against likely phrases from the sample data set. 
        The model can take approximately 15 seconds to respond for the first
        prediction (as it is loading data sets, running the algorithm). Entries
        after that should return predictions within a few seconds. Know that 
        while the model is based on thousands upon thousands of data entries, 
        the accuracy is far from perfect.'),
    hr(),
    h4('Top Predicted Next Words'),
    hr(),
    h4(textOutput("text1")),
    hr()
  )
))