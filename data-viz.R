## --------------------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(fig.align = 'center')


## --------------------------------------------------------------------------------------------------------------
#| fig-align: center


library(ggplot2)
ggplot(mpg, aes(x=displ, y = cty)) + 
  geom_point(stat = 'identity') + 
  labs(title = 'Does engine displacement correlate with miles per gallon?',
       x = 'Engine Displacement (L)', 
       y = 'City mpg') +
  geom_smooth(method = 'lm', se = F, color = 'red') + 
  theme_bw() + 
  theme(aspect.ratio = 1/2)



## --------------------------------------------------------------------------------------------------------------
set.seed(250)
examp_data <- expand.grid(
  Trt1 = 1:2,
  Trt2 = 1:2,
  Rep = 1:2
)
examp_data$response <- round(rnorm(8, 10),2)
knitr::kable(examp_data, align = 'c')


## --------------------------------------------------------------------------------------------------------------
library(dplyr)
library(tidyr)
set.seed(250)
tidy_examp <- slice_sample(select(diamonds, cut, color, price), n = 100) %>% 
  group_by(cut, color) %>% 
  summarize(price = round(mean(price, na.rm = T)),
            .groups = 'keep')
tidy_examp %>% 
  pivot_wider(names_from = cut,
              values_from = price) %>% 
  knitr::kable(caption = 'Average diamond price by cut and color')


## --------------------------------------------------------------------------------------------------------------
knitr::kable(head(tidy_examp,6), caption = 'Average diamond price by cut and color.')


## --------------------------------------------------------------------------------------------------------------
#| include: true
#| eval: false
#| echo: true

# ggplot(data = data, mapping = aes(...)) +
#   geom_FUNCTION(aes(...), ...) +
#   scale_FUNCTION(...) +
#   facet_FUNCTION(...) +
#   labs(title = '', subtitle = '', x = '', y = '') +
#   theme_FUNCTION(...) +
#   coord_FUNCTION(...)
# 


## --------------------------------------------------------------------------------------------------------------
#| eval: false
#| echo: true

# install.packages(c('ggplot2', 'palmerpenguins', 'ggthemes'))
# library(ggplot2)
# library(palmerpenguins)
# library(ggthemes)


## --------------------------------------------------------------------------------------------------------------
library(ggplot2)
library(palmerpenguins)
library(ggthemes)

knitr::kable(head(penguins), caption = 'Palmer Penguins Data')


## --------------------------------------------------------------------------------------------------------------
#| echo: true

ggplot(data = penguins, mapping = aes(x = bill_length_mm, y = bill_depth_mm, color = species)) + 
  geom_point(aes(shape = species), alpha = 2/3, size = 1) + 
  theme_bw() + 
  labs(x = 'Bill length (mm)', y = 'Bill depth (mm)',
       title = 'Bill length vs. Bill depth', subtitle = 'By species',
       color = 'Species', shape = 'Species', caption = 'Source: palmerpenguins') +
  facet_grid(.~island) + 
  theme(aspect.ratio = 1/2,
        legend.position = 'bottom')


## --------------------------------------------------------------------------------------------------------------
#| echo: true

ggplot(data = penguins, mapping = aes(x = bill_length_mm, y = bill_depth_mm, color = sex)) + 
  geom_point(aes(shape = sex), alpha = 2/3) +
  facet_grid(.~species) + 
  labs(x = 'Bill length (mm)', y = 'Bill depth (mm)',
     title = 'Bill length vs. Bill depth', subtitle = 'By sex',
     color = 'Sex', shape = 'Sex', caption = 'Source: palmerpenguins package') +
  theme_bw() + 
  theme(aspect.ratio = 1/2)



## --------------------------------------------------------------------------------------------------------------
#| echo: true
#| fig-align: center

ggplot(data = economics, mapping = aes(x = date, y = uempmed)) + 
  # geom_line(color = 'black') + 
  geom_area(fill = 'skyblue', color = 'black') +
  theme_bw() + 
  labs(x = '',
       y = 'Median durration of unemployment\n(in weeks)',
       title = 'Longer unemployment during Great Recession',
       subtitle = 'in the United States',
       caption = 'Source: ggplot2::economics') + 
  scale_x_date(date_breaks = '5 years', date_labels = '%Y') + 
  scale_y_continuous(limits = c(0,27), expand = c(0,0)) + 
  theme(aspect.ratio = 1/2)


## --------------------------------------------------------------------------------------------------------------
#| echo: true

library(dplyr)
library(lubridate)
economics2000s <- economics %>% 
  mutate(year = year(date)) %>% 
  filter(year >= 2000) %>% 
  group_by(year) %>% 
  summarise(mean_unemploy = mean(100*unemploy/pop))



## --------------------------------------------------------------------------------------------------------------
#| echo: true

economics2000s %>% 
  ggplot(mapping = aes(x = year, y = mean_unemploy)) + 
  geom_bar(stat = 'identity', width = 1,
           color = 'black', fill = 'skyblue') + 
  labs(x = '', y = 'Unemployment rate (%)', title = 'Unemployment rate in the United States',
       subtitle = '2000 to 2015') +
  scale_y_continuous(limits = c(0, 5), expand = c(0,0)) + 
  scale_x_continuous(breaks = 2000:2015) +
  theme_bw() +
  theme(aspect.ratio = 1/2, 
        panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank(),
        plot.background = element_rect(color = 'black', fill = 'grey80'),
        plot.title = element_text(size = 16, family = 'times', face = 'bold', hjust = 0.5),
        plot.subtitle = element_text(size = 12, family = 'times', hjust = 0.5))


## --------------------------------------------------------------------------------------------------------------
#| echo: true
#| eval: false

# myplot <- economics2000s %>%
#   ggplot(mapping = aes(x = year, y = mean_unemploy)) +
#   geom_bar(stat = 'identity', width = 1,
#            color = 'black', fill = 'skyblue') +
#   labs(x = '', y = 'Unemployment rate (%)', title = 'Unemployment rate in the United States') +
#   scale_y_continuous(limits = c(0, 5), expand = c(0,0)) +
#   scale_x_continuous(breaks = 2000:2015) +
#   theme_bw() + theme(aspect.ratio = 1/2)
# 
# ggsave('unemploy.png', width = 6, dpi = 600)
# 

