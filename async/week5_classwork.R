install.packages("ggplot2")
library(ggplot2)


mtc <- mtcars
hist(mtc$mpg, breaks=4)

g<-ggplot(mtc, aes(x=mpg)) + geom_histogram(bins=5, color="black", fill="white")

g+ggtitle("mpg buckets")

timeToNYC <- c(4,4.5,3.5,5,4,4.2)
timeToNYCWeek2 <- c(4.5,5,3.8,5.2,4.6,4.3)
day <- c("mon", "tues", "wed", "thurs", "fri", "sat")

week1<- c(1,1,1,1,1,1)
week2<- c(2,2,2,2,2,2)
time<- c(timeToNYC, timeToNYCWeek2)
week <- as.factor(c(week1, week2))
dayOfWeek <-c(day,day)

df <- data.frame(day,timeToNYC,timeToNYCWeek2)

y <- ggplot(df, aes(x=day, y=timeToNYC, group=1)) + geom_line(color="red", linetype="dashed", size=1.5)

x <- ggplot(df2, aes(x=dayOfWeek, group=week, color=week)) + geom_line(aes(y=time))

