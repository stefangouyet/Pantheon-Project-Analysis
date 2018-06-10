library(ggplot2)
library(dplyr)
library(gganimate)
library(ggmap)
library(ggthemes)

pantheon <- read.csv("database.csv")

head(pantheon)

names(pantheon)

summary(pantheon)

sample_pantheon <- sample_n(pantheon, size=100)

most_popular <- pantheon %>% filter(page_views > 30000000) %>% filter(!is.na(latitude))

world <- ggplot(data=most_popular, aes(x = longitude, y = latitude, frame = birth_year, 
                                       cumulative = TRUE)) +
  borders("world", colour = "grey", fill = "grey") +
  theme_map() 

pantheon_plot <- world +
  geom_point(color="red")

gganimate(pantheon_plot, interval = 1, "output1.gif",title_frame = TRUE)
