library(here)
library(dplyr)
con.df1 <- read.csv(here("original", "conflictdata.csv"))

con.df <- con.df1 %>%
  group_by(ISO, year) %>%
  summarise(best=sum(best)) 


con.df$conflict <- ifelse(con.df$best >= 25,1,0)
con.df$best <- NULL
con.df$year <- con.df$year+1

con.df <- rename(con.df, Year = year)

return(con.df)
