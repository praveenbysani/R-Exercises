library(dplyr)
library(nycflights13)

### basic functions
#filter rows with selection criteria &
filter(flights,month==1,day==1)
filter(flights,month==1 | day==1)
#order the rows in df in ascending order of arr_time, ties break with
#desc values of dep_time
arrange(flights,arr_time,desc(dep_time))
#select the attributes of df from year to day
select(flights,year:day)
#other functions starts_with, matches
select(flights,ends_with('delay'))
#rename() attribute names
#rename(flights,tail_num = tailnum)

#distinct commonly used along with select
distinct(select(flights, origin, dest))

#generate new attributes, mutate allows to access just created columns unlike transform
mutate(flights,gain = arr_delay - dep_delay, gain_per_hour = gain / (air_time / 60))
#sample 100 instances from data
sample_n(flights,100)

###group_by 
#computes number of flights for each aircraft in the dataset
summarise(group_by(flights,tailnum),count=n())
#computes count and average distance for each aircraft
summarise(group_by(flights,tailnum),count=n(),dist=mean(distance,na.rm = TRUE))

##progressive rollup of grouping
daily <- group_by(flights, year, month, day)
(per_day   <- summarise(daily, flights = n()))
#peels off day
(per_month <- summarise(per_day, flights = sum(flights)))






