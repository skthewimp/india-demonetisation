load('paymentsdec15.RData')

p2p <- payments[payments$Sequence %in% mth,]
p2p$Description <- factor(p2p$Description)
levels(p2p$Description) <- c("CreditCard","DebitCard","NEFT","IMPS","RTGS","Cheque","PPI","MobileBanking")
p2p$Value <- p2p$Value / 100
p2p$Volume <- p2p$Volume / 1e6
p2p$Volume <- ifelse(p2p$Description=='Cheque' & p2p$Date >= as.Date('2010-04-01') 
                     & p2p$Date <= as.Date('2011-04-01'),p2p$Volume*10,p2p$Volume)
p2p$Value <- ifelse(p2p$Description=='Cheque' & p2p$Date >= as.Date('2010-04-01') 
                    & p2p$Date <= as.Date('2011-04-01'),p2p$Value*100,p2p$Value)

p2p$Ticketsize <- p2p$Value * 1e9 / p2p$Volume / 1e6

p2p <- p2p[with(p2p,order(Description,Date)),]

pdf('~/Documents/work/Mint/paymentsgraphs.pdf',24,14)

print(ggplot(p2p[p2p$Date >= as.Date('2012-01-01') & p2p$Description %in% c("NEFT","Cheque"),],aes(x=Date,y=Value)) + 
  geom_line(aes(col=Description),lwd=2) + theme_bw(24) + scale_colour_brewer(palette='Set1') + 
  theme(legend.title=element_blank()) + scale_y_continuous("Transactions (Rs. Billion)") + 
  ggtitle("Total value of transactions using NEFT and Cheque"))


print(ggplot(p2p[p2p$Date >= as.Date('2012-01-01') & p2p$Description %in% c("NEFT","Cheque"),],aes(x=Date,y=Volume)) + 
  geom_line(aes(col=Description),lwd=2) + theme_bw(24) + scale_colour_brewer(palette='Set1') + 
  theme(legend.title=element_blank()) + scale_y_continuous("Transactions (Million)") + 
  ggtitle("Number of transactions using NEFT and Cheque (million)"))


print(ggplot(p2p[ p2p$Description %in% c("RTGS","Cheque") & p2p$Date >= as.Date('2005-04-01'),],aes(x=Date,y=Value/1000)) + 
  geom_line(aes(col=Description),lwd=2) + theme_bw(24) + 
  scale_colour_brewer(palette='Set1') + theme(legend.title=element_blank()) + 
  scale_y_continuous("Transactions (Rs. Trillion)") +
  ggtitle("Value of transactions using RTGS and Cheque (Rs. Trillion)"))

print(qplot(Date,Value,fill=Description,data=p2p[p2p$Date >= as.Date('2005-04-01'),],
      stat='identity',position='fill',geom='bar',xlab='',ylab='',
      main="Share of payment systems (value)") + theme_bw(24) + scale_fill_brewer(palette='Set2'))

print(qplot(Date,Volume,fill=Description,data=p2p[p2p$Date >= as.Date('2005-04-01'),],
      stat='identity',position='fill',geom='bar',xlab='',ylab='',
      main="Share of payment systems (Volume)") + theme_bw(24) + scale_fill_brewer(palette='Set3'))

dev.off() 

