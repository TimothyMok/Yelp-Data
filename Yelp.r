# Install and load the jsonlite library 
install.packages("jsonlite")
install.packages("tibble")
library("jsonlite")
library("tibble")

# load in each individual json file and put them into datasets via jsonlite
business<-stream_in(file("business.json"))
head(business,3)

businessf<-flatten(business)
str(businessf)

businesst<-as.data.frame(businessf)
head(businesst,10)




###########################################
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


