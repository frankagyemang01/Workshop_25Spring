
## ----message=FALSE, warning=FALSE---------------------------------------------
library(readr)
midwest <- read_csv("https://github.com/unl-statistics/R-workshops/raw/main/r-format/data/midwest.csv")

## ----warning=FALSE, message=FALSE, echo = TRUE--------------------------------
library(lubridate) # works with dates
library(tidyverse)
values <- c(midwest_data$X3, midwest_data$X5, midwest_data$X7, 
            midwest_data$X9, midwest_data$X11)
dates <- c(paste(midwest_data$X1, midwest_data$X2, sep = "-"), 
           paste(midwest_data$X1, midwest_data$X4, sep = "-"),
           paste(midwest_data$X1, midwest_data$X6, sep = "-"),
           paste(midwest_data$X1, midwest_data$X8, sep = "-"),
           paste(midwest_data$X1, midwest_data$X10, sep = "-"))

dates <- dates[!is.na(values)] #removing NAs
values <- values[!is.na(values)] #removing Nas

dates <- ymd(dates)

midwest_gas <- data_frame(date = dates, price = values)
midwest_gas <- arrange(midwest_gas, dates)


## ----warning=FALSE, message=FALSE, fig.width=7, fig.height=4, echo = TRUE, fig.align='center'----
library(ggplot2)

ggplot(midwest_gas, aes(x = date, y = price)) + geom_line()


## ----eval=FALSE, echo = TRUE--------------------------------------------------
library(readxl)
midwest2 <- read_excel("https://github.com/unl-statistics/R-workshops/raw/main/r-format/data/midwest.xls")
head(midwest2)




## ----eval=FALSE, echo = TRUE--------------------------------------------------
midwest2 <- read_excel("https://github.com/unl-statistics/R-workshops/raw/main/r-format/data/midwest.xls", skip = 1) #<<
names(midwest2)[1] <- "Year-Month"
head(midwest2)

################################################################################

library(tidyverse)
pitch <- read_csv("https://raw.githubusercontent.com/unl-statistics/R-workshops/main/r-format/data/pitch.csv")
pitch[-1] %>% 
  filter(pitcher_hand == "R", pitch_type == "CU") %>%
  head(n=4)


## ----arr.desc2, echo=FALSE, eval = TRUE---------------------------------------
pitch %>% 
  subset(select = c("playerid", "spin_rate")) %>%
  arrange(desc(playerid), spin_rate) %>% 
  head(5)



## ----arr.asc2, echo=FALSE, eval = TRUE----------------------------------------
pitch %>% 
  subset(select = c("playerid", "spin_rate")) %>%
  arrange(playerid, spin_rate) %>% 
  head(5)


## ----echo=FALSE, eval = TRUE--------------------------------------------------
pitch %>% 
  select(playerid, pitcher_hand, action_result, spin_rate) %>%
  head()

pitch %>%
  summarise(mean_spinrate = mean(spin_rate, na.rm=TRUE), 
            sd_spinrate = sd(spin_rate, na.rm = TRUE))


## ----echo = FALSE, eval = TRUE------------------------------------------------
pitch %>%
  group_by(playerid) %>%
  summarise(mean_spinrate = mean(spin_rate, na.rm=TRUE), 
            sd_spinrate = sd(spin_rate, na.rm = TRUE)) %>% 
  head(5)


## ----echo = TRUE--------------------------------------------------------------
pitch %>%
  select(playerid, spin_rate, action_result) %>%
  group_by(playerid, action_result) %>%
  summarise(mean_spin = mean(spin_rate), 
            sd_spin = sd(spin_rate)) %>%
  mutate(mean = sum(mean_spin) / n()) %>%
  mutate(difference = mean - mean_spin) %>% head()


## ----echo=TRUE----------------------------------------------------------------
pitch %>% 
  select(pitcher_hand) %>% 
  mutate(Handedness = ifelse(pitcher_hand == "R", "Right", "Left")) %>% head()

################################################################################

library(tidyverse)
data(french_fries, package="reshape2")

## ----echo=TRUE, eval=FALSE----------------------------------------------------
## french_fries <- read_csv("frenchfries.csv")
## head(french_fries)


## ----echo=FALSE---------------------------------------------------------------
head(french_fries)

french_fries_long <- french_fries %>% 
  pivot_longer(cols = potato:painty, #5:9
               names_to = "variable", 
               values_to = "rating")

french_fries_long %>% 
  head() 

## ----warning = FALSE, echo=TRUE-----------------------------------------------
french_fries_wide <- french_fries_long %>% 
  pivot_wider(names_from = variable, 
              values_from = rating, 
              values_fill = NA)



## ----echo = FALSE-------------------------------------------------------------

head(french_fries_wide, 4) 


## -----------------------------------------------------------------------------
french_fries_wide <- french_fries_long %>% 
  pivot_wider(names_from = rep, 
              values_from = rating)


## ----echo = FALSE-------------------------------------------------------------
head(french_fries_wide, 3)
