#####################################
# Group assignment 1
# Lanping Wei & Jonathan Hygrell
# DS21 Solna
#####################################

library(tidyverse)
library(stringr)

#Import csv.file and make it a dataframe
music <- read.csv("music.csv", header = TRUE)
View(music)

df_music <- as_tibble(music)
View(df_music)


#Change order of columns and make "Ranks" coulmn number one
music_relocate <- df_music %>% relocate(ranks)
View(music_relocate)


#Add columns together and remove NA values
genre_ranking<- unite(music_relocate, genre_rankings, 
                       "post_metal_rank", "black_metal_rank","death_metal_rank",
                       remove=FALSE, na.rm = T)
View(genre_ranking)
genre_ranking[,4]

#Split column length into columns "minutes" and "seconds"
genre_ranking <- separate(genre_ranking, length, into= c("minutes","seconds") )
View(genre_ranking)

#Group by artist and show the highest average rank
music_group <- genre_ranking %>% group_by(artist) %>%  summarize(mean =mean(ranks))%>% arrange(desc(mean))
View(music_group)

#Change column names
rename(genre_ranking, genres=genre_rankings)
names(genre_ranking)[4:6] <- c ("post metal","balck metal","death metal")
music_group

#Function diff takes the difference of an artists ranking based on artist name as input

diff <- function(artistname) {
  rankdiff <- genre_ranking %>%
    filter(artist == artistname) %>% 
     summarize(diff = max(ranks, na.rm=TRUE)-min(ranks, na.rm=TRUE) )
               
  return (rankdiff)
}

diff("Alcest")


#artist, mean and diff in a grouping of artists
genre_ranking %>% group_by(artist) %>% summarize(mean(ranks),diff("Mgla"))


