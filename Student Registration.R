library(readxl)
library(tidyverse)
library(dplyr)
library(lubridate)
library(ggplot2)
rm(list = ls())

setwd("~/DATA 331/Rstudio file")

course <- read_excel('Course.xlsx', .name_repair = "universal")
registration <- read_excel('Registration.xlsx', .name_repair = "universal")
student <-  read_excel('Student.xlsx', .name_repair = "universal")

all_df <- registration %>%
  left_join(course, by = c('Instance.ID')) %>%
  left_join(student, by = c('Student.ID')) 

compSciStudent <- all_df %>%
  dplyr::filter(Title == "Computer Science")


AllPaymentPlan <- all_df %>%
  dplyr::filter(Payment.Plan == 'TRUE')

FirstQuarterClass <- all_df %>%
  dplyr::filter(Start.Date >= '2021-08-01' & End.Date <= '2021-12-29') 

TotalBalanceByPlan <- all_df %>% 
  dplyr::filter(Payment.Plan == "TRUE") %>%
  dplyr::group_by(Payment.Plan) %>%
  dplyr::summarise(Balance.Due = sum(Balance.Due))

TotalCostByMajor <- all_df %>%
  dplyr::group_by(Title) %>%
  dplyr::summarise(Total.Cost = sum(Total.Cost))
