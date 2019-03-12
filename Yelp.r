install.packages("data.table")
install.packages("tm")
install.packages("SnowballC")
install.packages("Matrix")
install.packages("crqanlp")

library("data.table")
library("NLP")
library("tm")
library("Matrix")
library("SnowballC")
library("crqanlp")


##***************
## business<-fread("yelp_business.csv")
review<-fread("yelp_review.csv")

## str(business)
## str(review)


########################################################################
########################################################################
########################################################################
########################################################################
########################################################################


## Version 2 - "positive comments"
review<-fread("yelp_review.csv")
review<-review[,c(3,4,6)]
## business<-business[,c(1,2,5,10,13)]
review<-subset(review, stars>3)
review<-review[,3]
##***************

corpus <- Corpus(VectorSource(review$text))

# process text (your methods may differ)
skipWords <- function(x) removeWords(x, stopwords("english"))
funcs <- list(tolower, removePunctuation, removeNumbers, stripWhitespace, skipWords)
a <- tm_map(corpus, FUN = tm_reduce, tmFuns = funcs)
a.dtm1 <- TermDocumentMatrix(a, control = list(wordLengths = c(3,10)))

a.dtm2<-removeSparseTerms(a.dtm1, 0.97)
m <- as.matrix(a.dtm2)
v <- sort(rowSums(m), decreasing=TRUE)
head(v, 70)

########################################################################
########################################################################
########################################################################
########################################################################
########################################################################


## Version 3 - "negative comments"
review<-fread("yelp_review.csv")
review<-review[,c(3,4,6)]
## business<-business[,c(1,2,5,10,13)]
review<-subset(review, stars<3)
review<-review[,3]
##***************

corpus <- Corpus(VectorSource(review$text))

# process text (your methods may differ)
skipWords <- function(x) removeWords(x, stopwords("english"))
funcs <- list(tolower, removePunctuation, removeNumbers, stripWhitespace, skipWords)
a <- tm_map(corpus, FUN = tm_reduce, tmFuns = funcs)
a.dtm1 <- TermDocumentMatrix(a, control = list(wordLengths = c(3,10)))

a.dtm2<-removeSparseTerms(a.dtm1, 0.97)
m <- as.matrix(a.dtm2)
v <- sort(rowSums(m), decreasing=TRUE)
head(v, 300)

