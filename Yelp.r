######################################################################################
######################################################################################
##                              Student: Timothy Mok                                ##   
##                               Course: CMKE 136                                   ##
##                                Dataset: Yelp                                     ##
######################################################################################
######################################################################################

# Install and load the jsonlite library 
install.packages("jsonlite")
install.packages("tibble")
library("jsonlite")
library("tibble")

######################################################################################
##     ETL of dataset, first set working directory of R to the dataset folder.      ##
######################################################################################

# load in each individual json file and put them into datasets via jsonlite
business<-stream_in(file("business.json"))
head(business,15)

# Flatten the dataset
businessf<-flatten(business)
str(businessf)

# Apply the flatten dataset to a data frame
businesst<-as.data.frame(businessf)
head(businesst,5)

######################################################################################
##                         Exploratory Analysis on Dataset                          ##
######################################################################################

# Display all the attribute names
matrix(colnames(business),nrow=length(business))

# Count the total number of rows in business hours 
# (192,609)
nrow(business$hours)

# Total of hours that is all NA, in which no business hours being input 
# (44,830)
sum(rowSums(is.na(business$hours))==7)



######################################################################################











review<-stream_in(file("review.json"))
head(review,3)

user<-stream_in(file("user.json"))
head(user,3)

checkin<-stream_in(file("checkin.json"))
head(checkin,3)

tip<-stream_in(file("tip.json"))
head(tip,3)

photo<-stream_in(file("photo.json"))
head(photo,3)


