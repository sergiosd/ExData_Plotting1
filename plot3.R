
loadData<-function()
## function to load data from 1-2-2007 to 2-2-2007 and format that data
## return data frame with formatted data
{
    con<-file("household_power_consumption.txt")
    open(con)
    ah<-read.csv(con,nrow=1,head=T,sep=";",dec=".") # reading to capture heading
    a<-read.csv(con,skip=66634,nrow=2880,sep=";",dec=".") # data reading
    names(a)<-names(ah) # assign right names
    x<-paste(a$Date,a$Time) # x is the concatenation of date time
    x<-strptime(x,"%d/%m/%Y %H:%M:%S") # conversion to posixct type
    y<-cbind(x,a) # y is the data frame with posixct types+strings
    y<-y[,-2] # delete old date column
    y<-y[,-2] # delete old time column
    names(y)[1]="DateTime" # assign name for posixct type
    close(con)
    y
}
plot3Data<-function(a,type="WINDOWS")
## function to create chart
## parameters a=data to be charted, type="wINDOWS" to work with windows 
## graphic device, type="PNG" to generate png file with resolution=480x480
{
    if(type=="WINDOWS") windows()
    else if (type=="PNG") png("plot3.png",width=480,height=480)
    else return
    plot(a$DateTime,a$Sub_metering_1, col="black",xlab=" ",main=NULL,
         type="l",ylab="Energy sub metering")
    lines(a$DateTime,a$Sub_metering_2,col="red")
    lines(a$DateTime,a$Sub_metering_3,col="blue")
    legend("topright", col = c("black","red","blue"), pch="_",
           legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

    if (type=="PNG")  dev.off()
}

Sys.setlocale("LC_TIME", "English")  # to show days of the week in english
data<-loadData()
plot3Data(data,"PNG")
