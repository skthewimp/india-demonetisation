pay <- read_excel('~/Documents/work/data work/rbipaymentsapr18.xlsx')
pay$Date <- as.Date(paste('01-',pay$`Month/Year`, sep=''), '%d-%b-%Y')
pos <- pay[,c(82, 56, 57, 50, 51, 58, 59)]
names(pos) <- c('Date', 'DCVolume', 'DCValue', 'CCVolume', 'CCValue', 'PPIVolume', 'PPIValue')
pos$PPIValue <- as.numeric(pos$PPIValue)
pos$PPIVolume <- as.numeric(pos$PPIVolume)

pos %>% filter(Date >= as.Date('2012-06-01')) %>% ggplot(aes(x=Date,y=CCVolume)) + geom_line() + geom_point() + xlab('') + ggtitle('Number of Credit Card swipes (millions)') + theme_bw() + geom_smooth(data=pos %>% filter(Date >= as.Date('2012-06-01') & Date <= as.Date('2016-09-01')), aes(x=Date,y=CCVolume), se=F, method='lm', fullrange=TRUE, lty=2) + geom_vline(xintercept = as.Date('2016-11-01'), col='red', lwd=2, lty=3)

pos %>% filter(Date >= as.Date('2012-06-01')) %>% ggplot(aes(x=Date,y=DCVolume)) + geom_line() + geom_point() + xlab('') + ggtitle('Number of Debit Card swipes (millions)') + theme_bw() + geom_smooth(data=pos %>% filter(Date >= as.Date('2012-06-01') & Date <= as.Date('2016-09-01')), aes(x=Date,y=DCVolume), se=F, method='lm', fullrange=TRUE, lty=2) + geom_vline(xintercept = as.Date('2016-11-01'), col='red', lwd=2, lty=3)

pos %>% filter(Date >= as.Date('2012-06-01')) %>% ggplot(aes(x=Date,y=DCValue/DCVolume*1000)) + geom_line() + geom_point() + xlab('') + ggtitle('Average size of Debit Card PoS transaction') + theme_bw() + geom_smooth(data=pos %>% filter(Date >= as.Date('2012-06-01') & Date <= as.Date('2016-09-01')), aes(x=Date,y=DCValue/DCVolume*1000), se=F, method='lm', fullrange=TRUE, lty=2) + geom_vline(xintercept = as.Date('2016-11-01'), col='red', lwd=2, lty=3)

pos %>% filter(Date >= as.Date('2012-06-01')) %>% ggplot(aes(x=Date,y=CCValue/CCVolume*1000)) + geom_line() + geom_point() + xlab('') + ggtitle('Average size of Credit Card PoS transaction') + theme_bw() + geom_smooth(data=pos %>% filter(Date >= as.Date('2012-06-01') & Date <= as.Date('2016-09-01')), aes(x=Date,y=CCValue/CCVolume*1000), se=F, method='lm', fullrange=TRUE, lty=2) + geom_vline(xintercept = as.Date('2016-11-01'), col='red', lwd=2, lty=3)

pos %>% filter(Date >= as.Date('2012-06-01')) %>% ggplot(aes(x=Date,y=PPIValue/PPIVolume*1000)) + geom_line() + geom_point() + xlab('') + ggtitle('Average size of mobile wallet transaction') + theme_bw() + geom_smooth(data=pos %>% filter(Date >= as.Date('2012-06-01') & Date <= as.Date('2016-09-01')), aes(x=Date,y=PPIValue/PPIVolume*1000), se=F, method='lm', fullrange=TRUE, lty=2) + geom_vline(xintercept = as.Date('2016-11-01'), col='red', lwd=2, lty=3)


pos %>% filter(Date >= as.Date('2012-06-01')) %>% ggplot(aes(x=Date,y=CCValue)) + geom_line() + geom_point() + xlab('') + ggtitle('Total value of credit card transactions (Rs. Billions)') + theme_bw() + geom_smooth(data=pos %>% filter(Date >= as.Date('2012-06-01') & Date <= as.Date('2016-09-01')), aes(x=Date,y=CCValue), se=F, method='lm', fullrange=TRUE, lty=2) + geom_vline(xintercept = as.Date('2016-11-01'), col='red', lwd=2, lty=3)  + ylab('Rs. Billion')

pos %>% filter(Date >= as.Date('2012-06-01')) %>% ggplot(aes(x=Date,y=DCValue)) + geom_line() + geom_point() + xlab('') + ggtitle('Total value of debit card point of sale transactions per month (Rs. Billions)') + theme_bw() + geom_smooth(data=pos %>% filter(Date >= as.Date('2012-06-01') & Date <= as.Date('2016-09-01')), aes(x=Date,y=DCValue), se=F, method='lm', fullrange=TRUE, lty=2) + geom_vline(xintercept = as.Date('2016-11-01'), col='red', lwd=2, lty=3) + ylab('Rs. Billion')

pos %>% filter(Date >= as.Date('2012-06-01')) %>% ggplot(aes(x=Date,y=PPIValue)) + geom_line() + geom_point() + xlab('') + ggtitle('Total value of mobile wallet transactions (Rs. Billions)') + theme_bw() + geom_smooth(data=pos %>% filter(Date >= as.Date('2012-06-01') & Date <= as.Date('2016-09-01')), aes(x=Date,y=PPIValue), se=F, method='lm', fullrange=TRUE, lty=2) + geom_vline(xintercept = as.Date('2016-11-01'), col='red', lwd=2, lty=3)  + ylab('Rs. Billion')
