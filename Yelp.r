# DATA SOURCE:
# https://www.kaggle.com/z5025122/yelp-csv

#########################################################

# install.packages("data.table")
# install.packages("tm")
# install.packages("SnowballC")
# install.packages("Matrix")
# install.packages("crqanlp")
# install.packages("qdap")
# install.packages("qdapTools")

library("data.table")
library("NLP")dfm
library("tm")
library("Matrix")
library("SnowballC")
library("crqanlp")
library("qdap")
library("wordcloud")
library("qdapTools")
library("ggplot2")
library("quanteda")
library("rpart")


#########################################################
# STEP 1 - Text Extraction, Corpus Creation
#########################################################

# Import file to fread as data.table
review<-fread("yelp_review.csv")

# Trim to 50,000 obvs
review<-review[c(1:1000)]

# Trim to rows we only neeeded
review<-review[,c(3,4,6)]
review<-subset(review,stars!=3)
review$positive<-as.factor(review$stars>3)
review<-review[,c(3,4)]

# Create a corpus
Corpus<-Corpus(VectorSource(review$text))


#########################################################
# STEP 2 - Text Processing
#########################################################

# Text processing
func<-list(tolower, removePunctuation, removeNumbers, stripWhitespace)
Corpus<-tm_map(Corpus,FUN=tm_reduce,tmFuns=func)
Corpus<-tm_map(Corpus, removeWords, stopwords('english'))
Corpus<-tm_map(Corpus, stemDocument)

# Verify the text have been process successfully
Corpus[[2]][1]

# Find the frequent terms in the corpus
freq<-freq_terms(Corpus,20)
plot(freq)


#########################################################
# STEP 3 - Create a Term Document Matrix
#########################################################

# Create a TDM for analysis
CorpusTDM<-TermDocumentMatrix(Corpus)

# Find the top appearing words in the Matrix
Corpus_Matrix<-as.matrix(CorpusTDM)
Corpus_Sum<-rowSums(Corpus_Matrix)
Corpus_Sorted<-sort(Corpus_Sum,decreasing=T)
Corpus_Sorted[1:20]
as.matrix(Corpus_Sorted[1:20],nrow=50)


#########################################################
# STEP 4 - Exploratory analysis on text
#########################################################

# Explore the top words with bar plot
barplot(Corpus_Sorted[1:25],col="green",las=2)

# Explore the data by using some word cloud
Corpus_Cloud<- data.frame(term = names(Corpus_Sorted),num = Corpus_Sorted)
wordcloud(Corpus_Cloud$term, Corpus_Cloud$num, max.words = 100, colors="blue")

# Simple words clustering & dentrogram
CorpusTDMx<-removeSparseTerms(CorpusTDM, sparse=0.9)
hc<-hclust(d = dist(CorpusTDMx, method = "euclidean"), method = "complete")
plot(hc)

# Association graph
asso<-findAssocs(CorpusTDM,"fit",0.05)
assodf<-list_vect2df(asso)[, 2:3]

ggplot(assodf, aes(y = assodf[, 1])) + 
  geom_point(aes(x = assodf[, 2]), 
             data = assodf, size = 3) + 
  ggtitle("Word Associations to 'fit'") + 
  theme_grey())

# N-grams, bi/tri Grams

#########################################################
# STEP 5 - Feature extraction, remove sparsity from TDM
#########################################################

# Tokenize descriptions
reviewtokens=tokens(review$text,what="word", remove_numbers=TRUE,remove_punct=TRUE, remove_symbols=TRUE, remove_hyphens=TRUE)
# Lowercase the tokens
reviewtokens=tokens_tolower(reviewtokens)
# remove stop words and unnecessary words
rmwords <- c("dress", "etc", "also", "xxs", "xs", "s")
reviewtokens=tokens_select(reviewtokens, stopwords(),selection = "remove")
reviewtokens=tokens_remove(reviewtokens,rmwords)
# Stemming tokens
reviewtokens=tokens_wordstem(reviewtokens,language = "english")
reviewtokens=tokens_ngrams(reviewtokens,n=1:2)

# Creating a bag of words
reviewtokensdfm=dfm(reviewtokens,tolower = FALSE)
# Remove sparsity
reviewSparse <- convert(reviewtokensdfm, "tm")
tm::removeSparseTerms(reviewSparse, 0.7)
# Create the dfm
dfm_trim(reviewtokensdfm, min_docfreq = 0.3)
x=dfm_trim(reviewtokensdfm, sparsity = 0.98)

#########################################################
# STEP 6 - Build the classification Model
#########################################################

## Setup a dataframe with features
df=convert(x,to="data.frame")

##Add the Y variable Recommend.IND????rbind
reviewtokensdf=rbind(review$Recommended.IND,df)
head(reviewtokensdf)
## Cleanup names
names(reviewtokensdf)[names(reviewtokensdf) == "review.Recommended.IND"] <- "recommend"
names(reviewtokensdf)=make.names(names(reviewtokensdf))
head(reviewtokensdf)
## Remove the original review.text column
reviewtokensdf=reviewtokensdf[,-c(2)]
head(reviewtokensdf)
reviewtokensdf$recommend=factor(reviewtokensdf$recommend)

## Building the CART model
tree=rpart(formula = recommend ~ ., data = reviewtokensdf, method="class",control = rpart.control(minsplit = 200,  minbucket = 30, cp = 0.0001))
printcp(tree)
plotcp(tree)
##Prune down the tree
bestcp=tree$cptable[which.min(tree$cptable[,"xerror"]),"CP"]
bestcp
ptree=prune(tree,cp=bestcp)
rpart.plot(ptree,cex = 0.6)
prp(ptree,faclen=0,cex =0.5,extra=2)