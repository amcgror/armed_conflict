library(here)
library(dplyr)
library(tidyr)

maternal <- read.csv(here("original", "maternalmortality.csv"))

maternal1 <- maternal %>%
  select(Country.Name, X2000:X2019)

colnames(maternal1) <- gsub("X", "", colnames(maternal1))
maternal2 <- pivot_longer(maternal1,
             cols=starts_with("20"),
             names_to = "Year", 
             values_to = "MatMor")

maternal2$Year <- as.numeric(maternal2$Year)

usethis::use_git_config(user.name = "amcgror",
                        user.email = "abigail.mcgrory@mail.utoronto.ca")

# to confirm, generate a git situation-report, your user name and email should appear under Git config (global)
usethis::git_sitrep()
usethis::use_git_config()
usethis::use_git() 
usethis::use_github()
