library(here)
library(dplyr)
library(tidyr)
library(purrr)
library(countrycode)

maternal <- read.csv(here("original", "maternalmortality.csv"))
inf.mort <- read.csv(here("original", "infantmortality.csv"))
mat.mort <- read.csv(here("original", "maternalmortality.csv"))
neo.mort <- read.csv(here("original", "neonatalmortality.csv"))
u5.mort <- read.csv(here("original", "under5mortality.csv"))



maternal1 <- maternal %>%
  select(Country.Name, X2000:X2019)

colnames(maternal1) <- gsub("X", "", colnames(maternal1))
maternal2 <- pivot_longer(maternal1,
             cols=starts_with("20"),
             names_to = "Year", 
             values_to = "MatMor")

maternal2$Year <- as.numeric(maternal2$Year)


clean <- function(x, name){
  df <- select(x, c(Country.Name, X2000:X2019))
  colnames(df) <- gsub("X", "", colnames(df))
  df2 <- pivot_longer(df,
                            cols=starts_with("20"),
                            names_to = "Year", 
                            values_to = paste0(substr(name,1,3),"Mor"))
  
  df2$Year <- as.numeric(df2$Year)
  return(df2)
}

new_mat.mort <- clean(mat.mort, "Maternal")
new_inf.mort <- clean(mat.mort, "Infant")
new_neo.mort <- clean(mat.mort, "Neonate")
new_u5.mort <- clean(mat.mort, "Under5")

df.list <- list(new_mat.mort, new_inf.mort, new_neo.mort, new_u5.mort)

comb.df <- reduce(df.list, full_join)

comb.df$ISO <- countrycode(comb.df$Country.Name,
                            origin = "country.name",
                            destination = "iso3c")
comb.df$Country.Name <- NULL

return(comb.df)


