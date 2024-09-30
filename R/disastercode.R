library(here)
library(dplyr)
library(countrycode)

dis <- read.csv(here("original", "disaster.csv"))


dis2 <- dis %>%
  filter(Year %in% 2000:2019, 
         Disaster.Type == "Earthquake"|
           Disaster.Type =="Drought") %>%
  select(Year, ISO, Disaster.Type)

dis2$drought <- ifelse(dis2$Disaster.Type == "Drought",1,0)
dis2$earthquake <- ifelse(dis2$Disaster.Type == "Earthquake",1,0) 

dis3 <- dis2 %>%
  group_by(ISO, Year) %>%
  summarise(drought=sum(drought), earthquake = sum(earthquake))

dis3$ISO <- countrycode(dis3$Country.Name,
                            origin = "country.name",
                            destination = "iso3c")

dis3$drought[is.na(dis3$drought)] <- 0
dis3$earthquake[is.na(dis3$earthquake)] <- 0


return(dis3)