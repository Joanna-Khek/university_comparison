##################################
##      LIBRARIES & DATA        ##
##################################

# libraries
library(magrittr)
library(dplyr)
library(highcharter)
library(tidyr)
library(reshape2)
library(reactable)
library(viridisLite)
library(fontawesome)
library(shiny)
library(argonR)
library(argonDash)
library(magrittr)
library(shinyWidgets)
library(shinyFeedback)

# data
intake_data = read.csv("intake_data_clean.csv", header=TRUE)
employment_data = read.csv("employment_data_Clean.csv", header=TRUE)
grades_data = read.csv("grades_data_clean.csv", header=TRUE)
graduates_data = read.csv("graduates_data_clean.csv", header=TRUE)
career_prospects_data = read.csv("career_prospects_clean.csv", header=TRUE)
world_rank_data = read.csv("world_university_ranking_data_clean.csv", header=TRUE)
world_survey_indices_data = read.csv("survey_indices_data_clean.csv", header=TRUE)
asia_rank_data = read.csv("asia_university_ranking_data_clean.csv", header=TRUE)
asia_survey_indices_data = read.csv("asia_survey_indices_data_clean.csv", header=TRUE)

# renaming columns
colnames(world_rank_data) = c("Year", "NUS_Ranking", "NTU_Ranking", "SMU_Ranking")
colnames(world_survey_indices_data) = c("Survey_Indices", "NUS_Ranking", "NUS_Score", "NTU_Ranking", "NTU_Score", "SMU_Ranking", "SMU_Score")
colnames(asia_rank_data) = c("Year", "NUS_Ranking", "NUS_Score", "NTU_Ranking", "NTU_Score")
colnames(asia_survey_indices_data) = c("Survey_Indices", "NUS_Ranking", "NUS_Score", "NTU_Ranking", "NTU_Score", "SMU_Ranking", "SMU_Score")

# data manipulation
world_rank_data$Year = as.factor(world_rank_data$Year)
world_rank_data_melt = melt(world_rank_data, id=c("Year"))
world_survey_indices_data_melt = melt(world_survey_indices_data, id=c("Survey_Indices"))

asia_rank_data$Year = as.factor(asia_rank_data$Year)
asia_rank_data_melt = melt(asia_rank_data, id=c("Year"))
asia_survey_indices_data_melt = melt(asia_survey_indices_data, id=c("Survey_Indices"))

intake_data = intake_data[order(intake_data$year),]
intake_data_nus = intake_data %>% group_by(year) %>% summarise(value=sum(nus))
intake_data_ntu = intake_data %>% group_by(year) %>% summarise(value=sum(ntu))
intake_data_smu = intake_data %>% group_by(year) %>% summarise(value=sum(smu))

graduates_data = graduates_data[order(graduates_data$year),]
graduates_data_nus = graduates_data %>% group_by(year) %>% summarise(value=sum(nus))
graduates_data_ntu = graduates_data %>% group_by(year) %>% summarise(value=sum(ntu))
graduates_data_smu = graduates_data %>% group_by(year) %>% summarise(value=sum(smu))

employment_data$year = as.factor(employment_data$year)
employment_data$employment_rate_overall = as.numeric(as.character(employment_data$employment_rate_overall))
employment_data$basic_monthly_mean = as.numeric(as.character(employment_data$basic_monthly_mean))
employment_data$gross_monthly_mean = as.numeric(as.character(employment_data$gross_monthly_mean))
employment_data_nus = employment_data %>% filter(university == "National University of Singapore")
employment_data_ntu = employment_data %>% filter(university == "Nanyang Technological University")
employment_data_smu = employment_data %>% filter(university == "Singapore Management University")

grades_data$Year_Intake = as.factor(grades_data$Year_Intake)
grades_data$A.Level.Grade.Point = as.numeric(as.character(grades_data$A.Level.Grade.Point))
grades_data$Diploma = as.numeric(as.character(grades_data$Diploma))
colnames(grades_data) = c("Year", "Year.Intake", "University", "School", "Faculty", "A.Level", "A.Level.Points", "CGPA")
grades_data_nus = grades_data %>% filter(University == "National University of Singapore")
grades_data_ntu = grades_data %>% filter(University == "Nanyang Technological University")
grades_data_smu = grades_data %>% filter(University == "Singapore Management University")