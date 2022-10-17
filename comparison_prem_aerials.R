library(worldfootballR)
library(tidyverse)
library(xlsx)

# get our data from FBref:
aerials <- fb_season_team_stats(country = "ENG", gender = "M", season_end_year = "2023", tier = "1st", stat_type = "misc")
aerials <- foul_data %>% 
  filter(Team_or_Opponent == "team")

# get our data ready for plotting
aerials %>% 
  # start plotting:
  ggplot(aes(x=Lost_Aerial_Duels, y=Won_Aerial_Duels)) +
  # we want to make it a scatter plot
  geom_point(size=6, colour="midnightblue", fill="midnightblue", alpha = 0.4, shape=21) +
  # lets also add team name labels
  ggrepel::geom_text_repel(aes(label = Squad), colour = "midnightblue", size=5) + 
  scale_x_continuous(limits = c(100,250), name = "Aerial Duels Lost") +
  scale_y_continuous(limits = c(80,250), "Aerial Duels Won") +
  # create a title and subtitle - all plots should have this
  ggtitle("WHICH TEAM IS BEST IN THE AIR?",
          subtitle = "Teams who win the most aerial duels and lose the least are best.") +
  # apply a pre-programmed general theme:
  theme_minimal() +
  # change the title and subtitle format
  theme(plot.title = element_text(size=28, face="bold"), plot.subtitle = element_text(size=22, colour="grey30"),
        # and change where the plot is aligned - in this case it's left-aligned
        plot.title.position = "plot", plot.caption.position = "plot",
        # change the size of aixs titles and text
        axis.title = element_text(size=16), axis.text = element_text(size = 14))
