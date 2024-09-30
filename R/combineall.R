library(dplyr)
library(here)
covs <- read.csv(here("original", "covariates.csv"))
covs <- rename(covs, Year = year)

source(here("R", "mortalitycode.R"))
source(here("R", "conflictcode.R"))
source(here("R", "disastercode.R"))

##Use ISO and Year to combine data. Make sure the "Year"
##is capitalized in conflict data.

full_df0 <- left_join(comb.df, dis3, by=c("ISO", "Year"))

full_df00 <- left_join(full_df0, con.df, by=c("ISO", "Year"))

full_df <- left_join(full_df00, covs, by=c("ISO", "Year"))



table(full_df$ISO)

write.csv(full_df,here("original", "conflict_primary_analysis.csv"), row.names = FALSE)

