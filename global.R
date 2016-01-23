library(shiny)
library(stringr)
uni<-read.table("unigram1.csv")
bi<-read.table("bigram1.csv")
tri<-read.table("trigram1.csv")

##Set up function to clean input from user
cleanInput <-function(input) {
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
  
}}