require(reshape)
require(plyr)
require(ggplot2)
require(gridExtra)


pay <- read.csv('~/Downloads/RBIB_Table_No._43___Payment_System_Indicators-3.csv')
pay$Date <- as.Date(substr(as.character(pay$Date),1,10),'%Y/%m/%d')
pay$Date <- as.Date(paste(format(pay$Date,'%Y-%m-'),'01',sep=''))
names(pay)[3:4] <- c("Item","Description")
items <- unique(pay[,3:4])
items$Newdesc <- gsub('[^a-zA-Z ]','',items$Description)
pay2 <- melt.data.frame(pay[,c(1,3,5,6)],id.vars=c('Date',"Item"))
pay2$PrevYear <- as.Date(paste(as.numeric(format(pay2$Date,'%Y'))-1,format(pay2$Date,'-%m-%d'),sep=''))
pay3 <- merge(pay2,pay2[,1:4],by.x=c("PrevYear","Item","variable"),by.y=c("Date","Item","variable"))
pay3$YoY <- pay3$value.x / pay3$value.y-1
avggrowth <- aggregate(YoY~Item+variable,pay3[pay3$Date >= as.Date('2014-11-01') & pay3$Date <= as.Date('2016-10-31'),],mean)

lastyear <- pay2[pay2$Date >= as.Date('2015-11-01') & pay2$Date <= as.Date('2016-08-01'),]
lastyear$PrevYear <- lastyear$Date
lastyear$Date <- as.Date(paste(as.numeric(format(lastyear$Date,'%Y'))+1,format(lastyear$Date,'-%m-%d'),sep=''))
lastyear <- merge(lastyear,avggrowth)
lastyear$value <- lastyear$value * (1 + lastyear$YoY)
lastyear$Type <- "Without Demonetisation"
pay2$Type <- "Actual"
pay4 <- rbind.fill(pay2,lastyear)

items <- items[with(items,order(Item)),]
items[24,3] <- paste(items[23,3],items[24,3],sep=': ')
items[25,3] <- paste(items[23,3],items[25,3],sep=': ')
items[27,3] <- paste(items[26,3],items[27,3],sep=': ')
items[28,3] <- paste(items[26,3],items[28,3],sep=': ')

octdup <- pay2[pay2$Date==as.Date('2016-10-01'),]
octdup$Type <- "Without Demonetisation"
pay4 <- rbind.fill(pay4,octdup)

pay4 <- merge(pay4,items[,c(1,3)])

pdf('~/Documents/work/Mint/Demonetisation impact November 2017.pdf',32,9)
for(i in c(1,20,21,25,28,29))
{
  p1 <- ggplot(pay4[pay4$Item==i & pay4$Date >= as.Date('2016-06-01') & pay4$variable=='Value',],aes(x=Date,y=value,col=Type,lty=Type,pch=Type)) + geom_line(lwd=2) + geom_point(size=4) + theme_bw(20) + scale_colour_brewer(palette='Set1') + ggtitle(paste(items[i,3],": Value of transactions (Rs. billion)")) + theme(legend.title=element_blank()) + xlab('') + ylab('Rs Billion')
  
  p2 <- ggplot(pay4[pay4$Item==i & pay4$Date >= as.Date('2016-06-01') & pay4$variable=='Volume',],aes(x=Date,y=value,col=Type,lty=Type,pch=Type)) + geom_line(lwd=2) + geom_point(size=4) + theme_bw(20) + scale_colour_brewer(palette='Set1') + ggtitle(paste(items[i,3],": Volume of transactions (Million)")) + theme(legend.title=element_blank()) + xlab('') + ylab('Million')
  
  grid.arrange(p1,p2,nrow=1)
}
dev.off()

