### Load libraries
library(tidyverse) # integrate by many packages: 
# ggplot2, dplyr, tidyr, stringr...
library(readr)     # read data

### Read data
# dat <- read_csv("Desktop/SC3L Tutorial/Data_cleaning_in_R/dat.csv")
dat <- read_csv("SC3L Tutorial/Data_cleaning_in_R/dat.csv")
dat

head(dat)

### Look at summary statistics
summary(dat)

### Check and Fix
  ## Duplicate check
  duplicated(dat$id)
  sum(duplicated(dat$id))
  which(duplicated(dat$id))
  
  dat[3,'id'] <- 3
  dat[3,1]
  dat
  
  ## Frequency
  table(dat$irrigation)
  

  ## Check for missing values
  sum(is.na(dat))
  
  which(is.na(dat), arr.ind = T)
    ## What if arr.ind = F?
  which(is.na(dat), arr.ind = F)
  # dat[2,3] <- 1000
  
  
  ## Impute missing values
  dat =
    dat %>% mutate(`2024-02-02`=replace_na(`2024-02-02`, 
                                               mean(`2024-02-02`, na.rm = T)))
  
  dat 
  
  ## Impute with irrigation group mean
  dat %>% group_by(irrigation) %>% 
    mutate(`2024-02-02` = 
             case_when(is.na(`2024-02-02`)~mean(`2024-02-02`, na.rm = T), 
                                    TRUE~as.numeric(`2024-02-02`)))


  ## Column name 
  colnames(dat)[5] = "2024-04-02"

  dat
  
  
