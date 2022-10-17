library(worldfootballR)
library(tidyverse)
library(xlsx)

# get our data from FBref:
foul_data <- fb_season_team_stats(country = "ENG", gender = "M", season_end_year = "2023", tier = "1st", stat_type = "misc")
foul_data <- foul_data %>% 
  filter(Team_or_Opponent == "team")

# get our data ready for plotting
foul_data %>% 
  # start plotting:
  ggplot(aes(x= CrdY + CrdR, y= Fls)) +
  # we want to make it a scatter plot
  geom_point(size=6, colour="midnightblue", fill="midnightblue", alpha = 0.4, shape=21) +
  # lets also add team name labels
  ggrepel::geom_text_repel(aes(label = Squad), colour = "midnightblue", size=5) + 
  scale_x_continuous(limits = c(0,40), name = "Cards (R/Y)") +
  scale_y_continuous(limits = c(0,300), "Fouls") +
  # create a title and subtitle - all plots should have this
  ggtitle("WHICH TEAMS GET AWAY WITH FOULS?",
          subtitle = "Teams who foul the most without getting carded are the luckiest.") +
  # apply a pre-programmed general theme:
  theme_minimal() +
  # change the title and subtitle format
  theme(plot.title = element_text(size=28, face="bold"), plot.subtitle = element_text(size=22, colour="grey30"),
        # and change where the plot is aligned - in this case it's left-aligned
        plot.title.position = "plot", plot.caption.position = "plot",
        # change the size of aixs titles and text
        axis.title = element_text(size=16), axis.text = element_text(size = 14))
