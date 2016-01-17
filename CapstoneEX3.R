library(qdap)
library(stringr)

setwd("C:/Users/jdlevy/Documents/datasciencecoursera/10_Capstone/final")
uni<-read.table("unigram.csv")
bi<-read.table("bigram.csv")
tri<-read.table("trigram.csv")
    quad<-read.table("quadgram.csv")

    

cleanInput <-function(word) {
  ##
  ## This function call takes in a user passes parameter and does basic
  ## preprocessing such as remove punctuation (retaining apostrophes),
  ## remove and preceding spaces, and remove multiple spaces in phrase.
  ##
  ## It returns the processed user input
  ##
  word <- tolower(input) #ensure input is in lower case
  word <- gsub("[^[:alnum:][:space:]\']", "",word) ##Remove numbers
  word <- gsub("[[:punct:]]", "",word) ##Remove punctuation
  word <- gsub("^[ ]{1,10}","",word)
  word <- gsub("[ ]{2,10}"," ",word)
  return(word)
}

suggest<-function(input){
inputs<-cleanInput(input)  ##Cleans input and classifies it as input
phrase<-paste("^",inputs,sep="") ##Preps input to be beginning of phrase
test<-grep(phrase, tri$Trigram, value=TRUE) ##Find trigrams beginning with input

  nCount<-length(grep(phrase, tri$Trigram, value=FALSE))
  if (nCount==0) {    ##If trigram phrase isn't found, look at bigrams
    one<-word(phrase, -1) ##Drop first word in phrase
    test2<-grep(one, bi$Bigram, value=TRUE) ##Search bigrams with last word in entered phrase
  iso1<-word(test2,-1) ##Obtain last word in found bigram phrases, which would be next word
pred<-iso1[1:3]
return(pred)   ##List of 1-5 predicted words based on data set
  } else {

iso<-word(test,-1) ##Obtain last word in trigram phrases
tt1<-iso[1]   ##Pull the top 5 of those
tt2<-iso[2]
tt3<-iso[3]
predd1<-which(uni$Onegram==tt1)  ##identify row number of word in unigram list
predd2<-which(uni$Onegram==tt2)  ##to help see which occurs more frequently
predd3<-which(uni$Onegram==tt3)
ll<-as.data.frame(list(c(predd1, predd2, predd3))) ##Combine numbers as df
colnames(ll)<-c("Position")  ##Set up df to sort
sorted2<-sort(ll$Position, decreasing=FALSE)  ##Sort df
words2<-uni$Onegram[sorted2]  ##Use df values to find unigrams 
pred2<-as.character(words2)   ##Prepare to list as predicted words
return(pred2)   ##List of 1-5 predicted words based on data set

  }
}



##Build presentation and md file (nojekyll connection?)

##Do that and THEN come back to shiny



##This gave the general "deployApp()" solution
http://www.r-bloggers.com/my-first-r-shiny-app-an-annotated-tutorial/
  
  ##Tried this one
  http://shiny.rstudio.com/articles/shinyapps.html
Got it from readme here: https://github.com/rstudio/rsconnect


##Try this step by step tutorial
http://rstudio.github.io/shiny/tutorial/

##Shiny tips
http://shiny.rstudio.com/articles/layout-guide.html

list(tags$head(tags$style("body {background-color: gray; }"))),
  ##Put in UI to change background color




  
  pred1<-which(uni$Onegram==t1)  ##identify row number of word in unigram list
  pred2<-which(uni$Onegram==t2)  ##to help see which occurs more frequently
  pred3<-which(uni$Onegram==t3)
  pred4<-which(uni$Onegram==t4)
  pred5<-which(uni$Onegram==t5)
  
  one<-gsub("\\s*\\w*$", "", phrase) ##Search bigrams with last word in entered phrase
  test2<-grep(one, bi$Bigram, value=TRUE)

*******************************************
*******************************************
*******************************************
*******************************************
*******************************************



predict <-function(input,cluster=7){
  ## This function takes as input two words (a bigram) and uses that to enter
  ## lookup tables to find the highest probability trigrams that result.
  ## It emplolys Good-Turing Smoothing and Katz back off when conditions would
  ## suggest their use.
  ##
  ## Within the function, it produces a dotchart based on a default of 7 clusters
  ## The function returns a data frame contain the top predicted word endings
  ##
  input <- cleanInput(input)
  inputSize<-length(strsplit(input, " ")[[1]])
  if (inputSize != 2) stop("Please input exactly two words.\n",
                           "Don't forget adding the space.")    # error handling
  if (inputSize == 2) {     #Checks phrase against trigrams
    
    input <- gsub(".* ","",input)    # isolates w2 as unigram
    nCount <- sum(tri[which(tri$Uni==input),2])
    if (nCount == 0) stop("This phrase is very unique.\n", 
                          "I can't seem to find it.")     # error handling
    