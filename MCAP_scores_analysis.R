#install.packages("tidyverse")
#install.packages("janitor")
#install.packages("readxl")
#install.packages("rvest")
#install.packages("ggmap")
#install.packages("geosphere")
#install.packages("sf")
#install.packages("tidycensus")

library(tidycensus)
library(tidyverse)
library(janitor)
library(readxl)
library(rvest)
library(ggmap)
library(geosphere)
library(sf)

#Table that includes proficiency in MCAP based on school and even race within school.
#Also includes if the student has a disability
scores <- read.csv("~/GitHub/patrick-mccaslin/2021_MCAP_ELA_Scores.csv") |>
  #filter(!is.na(as.numeric(Proficient.Pct))) %>%
  mutate(Proficient.Pct = as.numeric(Proficient.Pct))

#Only look at rows that contain all schools, disregarding race, gender, or
# other demographic factors
scores_all_grades <- scores |> 
  filter(Student.group == "All Students") |>
  select(School.Name, Proficient.Pct) |>
  arrange(desc(Proficient.Pct))
view(scores_all_grades)

#read in shp file for Montgomery County school district
districts <- st_read("MCPS_GIS_Data_2024_2025 (1)/Schools.shp")

#read in shp file for clusters
clusters <- st_read("MCPS_GIS_Data_2024_2025 (1)/Cluster.shp")


#read in school addresses, zip codes, etc
school_addresses <- read.csv("Maryland_Education_Facilities_-_PreK_thru_12_Education_(Public_Schools).csv")


