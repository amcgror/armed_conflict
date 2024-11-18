library(boot)
library(dplyr)

finaldata <- read.csv("C:/Users/Abigail McGrory/Documents/PhD/First Year/Special Topics/armed_conflict/original/conflict_primary_analysis.csv")
finaldata2 <- finaldata[complete.cases(finaldata[ , 13]),]

finaldata2[is.na(finaldata2)] <- 0

data.2017 <- finaldata2 %>%
  filter(Year == 2017)

###Infant mortality 

getmeddiff <- function(data, indices) {
  sample_data <- data[indices, ]
  group_meds <- tapply(sample_data$InfMor, sample_data$conflict, FUN = function(x) median(x,na.rm=TRUE))
  meddiff <- group_meds[2] - group_meds[1]
  return(meddiff)
}

boot.inf <- boot(data.2017, statistic = getmeddiff, strata = data.2017$conflict, R = 1000)
boot.ci((boot.inf))

###Under5 mortality 

getmeddiff <- function(data, indices) {
  sample_data <- data[indices, ]
  group_meds <- tapply(sample_data$UndMor, sample_data$conflict, FUN = function(x) median(x,na.rm=TRUE))
  meddiff <- group_meds[2] - group_meds[1]
  return(meddiff)
}

boot.und <- boot(data.2017, statistic = getmeddiff, strata = data.2017$conflict, R = 1000)
boot.ci(boot.und)

###Neonatal mortality 

getmeddiff <- function(data, indices) {
  sample_data <- data[indices, ]
  group_meds <- tapply(sample_data$NeoMor, sample_data$conflict, FUN = function(x) median(x,na.rm=TRUE))
  meddiff <- group_meds[2] - group_meds[1]
  return(meddiff)
}

boot.neo <- boot(data.2017, statistic = getmeddiff, strata = data.2017$conflict, R = 1000)
boot.ci(boot.und)
