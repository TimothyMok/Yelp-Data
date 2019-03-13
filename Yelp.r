### https://www.kaggle.com/z5025122/yelp-csv ###
install.packages("data.table")
install.packages("tm")
install.packages("SnowballC")
install.packages("Matrix")
install.packages("crqanlp")
install.packages("qdap")
library("data.table")
library("NLP")
library("tm")
library("Matrix")
library("SnowballC")
library("crqanlp")
library("qdap")
##***************
##business<-fread("yelp_business.csv")
review<-fread("yelp_review.csv")
## str(business)
str(review)

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
# set parameters for functions
skipWords<-function(x) removeWords(x, stopwords("english"))
fun<-list(tolower, removePunctuation, removeNumbers, stripWhitespace, skipWords)
# test to see if stop words will be removed
params<- list(wordLengths=c(3,10), minDocFreq = 1,removeNumbers = TRUE, stemming = TRUE,stopwords = TRUE, weighting = weightTf)

a<-tm_map(corpus,FUN=tm_reduce,tmFuns=fun)
##a.tdm <- TermDocumentMatrix(a,control=list(wordLengths=c(3,10)))
a.tdm <- TermDocumentMatrix(a,control = params)

b.tdm<-removeSparseTerms(a.tdm, 0.97)
m <- as.matrix(b.tdm)
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
head(v, 30)
########################################################################
########################################################################
########################################################################
########################################################################
########################################################################
########################################################################
########################################################################
########################################################################
########################################################################
########################################################################

## Version 4 - "negative comments"
review<-fread("yelp_review.csv")
review<-review[,c(3,4,6)]
## business<-business[,c(1,2,5,10,13)]
review<-subset(review, stars<3)
review<-review[,3]
##***************
corpus <- Corpus(VectorSource(review$text))
params <- list(minDocFreq = 1,removeNumbers = TRUE,stemming = TRUE,stopwords = TRUE,weighting = weightTf)
a.dtm1 <- TermDocumentMatrix(a, control = params)
a.dtm2<-removeSparseTerms(a.dtm1, 0.97)
m <- as.matrix(a.dtm2)
v <- sort(rowSums(m), decreasing=TRUE)
head(v, 30)
########################################################################
########################################################################
########################################################################
########################################################################
########################################################################
########################################################################
########################################################################
########################################################################
########################################################################
########################################################################

## Version 5 - "negative comments"
review<-fread("yelp_review.csv")
review<-review[,c(3,4,6)]
## business<-business[,c(1,2,5,10,13)]
review<-subset(review, stars<3)
review<-review[,3]
##***************
corpus <- Corpus(VectorSource(review$text))
# process text 
skipWords <- function(x) removeWords(x, stopwords("english"))
funcs <- list(tolower, removePunctuation, removeNumbers, stripWhitespace, skipWords)
a<-tm_map(corpus, FUN = tm_reduce, tmFuns = funcs)
a<-tm_map(a, removeWords, stopwords('english'))
a.dtm1 <- TermDocumentMatrix(a, control = list(wordLengths = c(3,10)))
a.dtm2<-removeSparseTerms(a.dtm1, 0.97)
m <- as.matrix(a.dtm2)
v <- sort(rowSums(m), decreasing=TRUE)
head(v, 30)
########################################################################
########################################################################
########################################################################
########################################################################
########################################################################
########################################################################
########################################################################
########################################################################
########################################################################
########################################################################

## Version 6 - "positive comments"
review<-fread("yelp_review.csv")
review<-review[,c(3,4,6)]
## business<-business[,c(1,2,5,10,13)]
review<-subset(review, stars>3)
review<-review[,3]
##***************
corpus <- Corpus(VectorSource(review$text))
# process text 
skipWords <- function(x) removeWords(x, stopwords("english"))
funcs <- list(tolower, removePunctuation, removeNumbers, stripWhitespace, skipWords)
a<-tm_map(corpus, FUN = tm_reduce, tmFuns = funcs)
a<-tm_map(a, removeWords, stopwords('english'))
a.dtm1 <- TermDocumentMatrix(a, control = list(wordLengths = c(3,10)))
a.dtm2<-removeSparseTerms(a.dtm1, 0.97)
m <- as.matrix(a.dtm2)

########################################################################
########################################################################
########################################################################
########################################################################
########################################################################
########################################################################
########################################################################

## Version 7 - "positive comments"
review<-fread("yelp_review.csv")
review<-review[,c(3,4,6)]
## business<-business[,c(1,2,5,10,13)]
review$positive<-as.factor(review$stars > 3)
review<-subset(review, stars>3)
review<-review[,3]
##***************
corpus <- Corpus(VectorSource(review$text))
# process text 
skipWords <- function(x) removeWords(x, stopwords("english"))
funcs <- list(tolower, removePunctuation, removeNumbers, stripWhitespace, skipWords)
a<-tm_map(corpus, FUN = tm_reduce, tmFuns = funcs)
a<-tm_map(a, removeWords, stopwords('english'))
a.dtm1 <- TermDocumentMatrix(a, control = list(wordLengths = c(3,10)))
a.dtm2<-removeSparseTerms(a.dtm1, 0.97)
m <- as.matrix(a.dtm2)
colnames(reviewsSparse) = make.names(colnames(reviewsSparse))
v <- sort(rowSums(m), decreasing=TRUE)
head(v, 30)
########################################################################
########################################################################
########################################################################
########################################################################
########################################################################
########################################################################
########################################################################

## Version 8 - "positive comments"
review<-fread("yelp_review.csv")
review<-review[,c(3,4,6)]
review<-subset(review,stars!=3)
review$positive<-as.factor(review$stars>3)
review<-review[,c(3,4)]
##***************
corpus <- Corpus(VectorSource(review$text))
# process text 
skipWords<-function(x) removeWords(x, stopwords("english"))
funcs<-list(tolower, removePunctuation, removeNumbers, stripWhitespace, skipWords)
a<-tm_map(corpus,FUN=tm_reduce,tmFuns=funcs)
a<-tm_map(a, removeWords, stopwords('english'))
a.tdm1 <- TermDocumentMatrix(a)
a.tdm2<-removeSparseTerms(a.tdm1, 0.95)
m <- as.matrix(a.dtm2)
i<-as.data.frame(m)
colnames(i)<-make.names(colnames(i))
i$positive<-review$positive

a.dtm2<-removeSparseTerms(a.dtm1, 0.97)
m <- as.matrix(a.dtm2)
colnames(reviewsSparse) = make.names(colnames(reviewsSparse))
v <- sort(rowSums(m), decreasing=TRUE)
head(v, 30)
########################################################################
########################################################################
########################################################################
########################################################################
## Version 9
# Import file to fread as data.table
review<-fread("yelp_review.csv")
# Trim to 50,000 obvs
review<-review[c(1:30000)]
# Trim to rows we only neeeded
review<-review[,c(3,4,6)]
review<-subset(review,stars!=3)
review$positive<-as.factor(review$stars>3)
review<-review[,c(3,4)]
# Create a corpus
Corpus<-Corpus(VectorSource(review$text))
# Text processing
##corpus_review=tm_map(corpus_review, removeWords,c("also", "get","like", "company", "made", "can", "im", "dress", "just", "i"))
func<-list(tolower, removePunctuation, removeNumbers, stripWhitespace)
Corpus<-tm_map(Corpus,FUN=tm_reduce,tmFuns=func)
Corpus<-tm_map(Corpus, removeWords, stopwords('english'))
Corpus<-tm_map(Corpus, stemDocument)
# Verify the text have been process successfully
Corpus[[2]][1]
# Find the frequent terms in the corpus
freq<-freq_terms(Corpus,20)
plot(freq)
# Create a DTM for analysis
CorpusTDM<-TermDocumentMatrix(Corpus)
# Find the top N-gram words in the Matrix
Corpus_Matrix<-as.matrix(CorpusTDM)
Corpus_Sum<-rowSums(Corpus_Matrix)
Corpus_Sorted<-sort(Corpus_Sum,decreasing=T)
Corpus_Sorted[1:20]
as.matrix(Corpus_Sorted[1:20],nrow=50)
# Explore the data by using some word cloud
Corpus_Cloud<- data.frame(term = names(Corpus_Sorted),num = Corpus_Sorted)
wordcloud(review_word_freq$term, review_word_freq$num,
          max.words = 50, colors = "red")