# Install the library to reach the JSON type file
install.packages("rjson");

# Load the rjson package from the library
library("rjson")

# 
business<-fromJSON(file="business.json")
businessdf<-as.data.frame(business)

review<-fromJSON(file="review.json")
print(review)

photo<-fromJSON(file="photo.json")
photoDF<-as.data.frame(photo)
print(photoDF)