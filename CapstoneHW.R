setwd("C:/Users/jdlevy/Documents/datasciencecoursera/10 Capstone")

download.file("https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip", destfile="Coursera-Swiftkey.zip")
unzip("Coursera-Swiftkey.zip")

setwd("C:/Users/jdlevy/Documents/datasciencecoursera/10 Capstone/final")

##Lists file/folder names from folder
list.files(path=".") 

setwd("C:/Users/jdlevy/Documents/datasciencecoursera/10 Capstone/final/en_Us")

##Lists file names from folder
list.files(path=".") 

##Pulled from https://class.coursera.org/dsscapstone-006/forum/thread?thread_id=11
USnews<-readLines("en_US.news.txt", 15000)
  ##Originally 5000 lines
USblogs <- readLines("en_US.blogs.txt", 15000)
UStwitter <- readLines("en_US.twitter.txt", 15000)

write(USnews, file="USnews2.txt")
write(USblogs, file="USblogs2.txt")
write(UStwitter, file="UStwitter2.txt")


library(tm)
library(RWeka) ##Got it!
library(qdap)
library(ggplot2)
library(stringi)
library(ngram)


threefiles<-file.path("C:/Users/jdlevy/Documents/datasciencecoursera/10 Capstone/final", "shortfile")

##Create corpus
corpus<-Corpus(DirSource(threefiles))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, tolower)
corpus <- tm_map(corpus, stemDocument)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, PlainTextDocument)


##Set N-grams from tokens
Onegram <- NGramTokenizer(corpus, Weka_control(min = 1, max = 1))
Bigram <- NGramTokenizer(corpus, Weka_control(min = 2, max = 2))
Trigram <- NGramTokenizer(corpus, Weka_control(min = 3, max = 3))
Quadgram<- NGramTokenizer(corpus, Weka_control(min=4, max=4))
  
##Modify to data frames
onet <- data.frame(table(Onegram))
twot <- data.frame(table(Bigram))
threet <- data.frame(table(Trigram))
quadt<- data.frame(table(Quadgram))

##Sort data frames
onesort<-onet[order(onet$Freq,decreasing=TRUE),]
twosort<-twot[order(twot$Freq,decreasing=TRUE),]
threesort<-threet[order(threet$Freq,decreasing=TRUE),]
quadsort<-quadt[order(quadt$Freq, decreasing=TRUE),]

write.table(onesort, file="unigram.csv")
write.table(twosort, file="bigram.csv")
write.table(threesort, file="trigram.csv")

##Gzipping files to be faster??
gzip("unigram.csv")
gzip("bigram.csv")
gzip("trigram.csv")

##Remove content from environment
rm(list=ls())

----------------------------------------------------------
----------------------------------------------------------
---------------------------------------------------------
##Use code below to build model for app
  
  
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




----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------

