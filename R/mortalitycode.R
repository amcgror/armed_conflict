library(here)
library(dplyr)
library(tidyr)
library(purrr)
library(countrycode)

inf.mort <- read.csv(here("original", "infantmortality.csv"), header=TRUE)
mat.mort <- read.csv(here("original", "maternalmortality.csv"), header=TRUE)
neo.mort <- read.csv(here("original", "neonatalmortality.csv"), header=TRUE)
u5.mort <- read.csv(here("original", "under5mortality.csv"), header=TRUE)




clean_data <- function(data,datname){
  new_data <- select(data, c(Country.Name,
                             X2000:X2019))
  colnames(new_data) <- gsub("X","",colnames(new_data))
  new_data <- pivot_longer(new_data, cols=starts_with("20"),
                           names_to='Year',
                           values_to= paste0(substr(datname, 1, 3),'Mor'))
  new_data$Year = as.numeric(new_data$Year)
  return(new_data)
}

new_mat.mort <- clean_data(mat.mort, "Maternal")
new_inf.mort <- clean_data(mat.mort, "Infant")
new_neo.mort <- clean_data(mat.mort, "Neonate")
new_u5.mort <- clean_data(mat.mort, "Under5")

df.list <- list(new_mat.mort, new_inf.mort, new_neo.mort, new_u5.mort)

comb.df <- reduce(df.list, full_join)

comb.df$ISO <- countrycode(comb.df$Country.Name,
                            origin = "country.name",
                            destination = "iso3c")
comb.df$Country.Name <- NULL

return(comb.df)


