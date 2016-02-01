library(Lahman)
library(nycflights13)
library(dplyr)

###to demonstrate the use of dplyr
#dplyr - plyr specialized for data frames

#find the players that played most matches in an year
players <- group_by(Batting,playerID)
games <- summarise(players,total=sum(G))
top_players <- arrange(games,desc(total))
top_5_players <- head(top_players,5)

#chain commands, same as above
#x %>% f(y) turns into f(x, y)
top_5_chain <- Batting %>%
  group_by(playerID) %>%
  summarise(total = sum(G)) %>%
  arrange(desc(total)) %>%
  head(5)
top_5_chain
