library(plyr)
library(dplyr)

#popular baby names by year and sex
bnames <- read.csv('code-data/baby-names2.csv',stringsAsFactors = FALSE)
#total births by year and sex
births <- read.csv('code-data/baby-births.csv',stringsAsFactors = FALSE)

#join two datasets
bnames2 <- merge(bnames,births, by=c('year','sex'))
# add new attributes
bnames2 <- transform(bnames2, n=round(prop*births))

#count the number of births per name over the years (using dplyr)
total_names <- summarise(group_by(bnames2,name),total=sum(n))
#count the number of births per name over the years (using plyr)
total_names <- ddply(bnames2,'name',summarise,n=sum(n))



