library(worldfootballR)
library(tidyverse)
library(xlsx)

# now let's get our season team shooting data from FBref:
prem_2023_shooting <- fb_season_team_stats(country = "ENG", gender = "M", season_end_year = "2023", tier = "1st", stat_type = "shooting")
prem_2023_shooting <- prem_2023_shooting %>% 
  filter(Team_or_Opponent == "team") %>%
  select(Squad, Gls_Standard, Sh_Standard)

# get our data ready for plotting
prem_2023_shooting %>% 
  # start plotting:
  ggplot(aes(x= Sh_Standard, y= Gls_Standard)) +
  # we want to make it a scatter plot
  geom_point(size=6, colour="midnightblue", fill="midnightblue", alpha = 0.4, shape=21) +
  # lets also add team name labels
  ggrepel::geom_text_repel(aes(label = Squad), colour = "midnightblue", size=5) + 
  # limit the x and y-axis to start at 10 and finish at 100
  scale_x_continuous(limits = c(0,250), name = "Shots") +
  scale_y_continuous(limits = c(0,40), "Goals") +
  # create a title and subtitle - all plots should have this
  ggtitle("WHICH TEAMS ARE THE MOST PROLIFIC THIS SEASON",
          subtitle = "Teams who have scored the most goals with the fewest shots are the most clinical") +
  # apply a pre-programmed general theme:
  theme_minimal() +
  # but then we can customise our plot even more - first we make the background black:
  # change the title and subtitle format
  theme(plot.title = element_text(size=28, face="bold"), plot.subtitle = element_text(size=22, colour="grey30"),
        # and change where the plot is aligned - in this case it's left-aligned
        plot.title.position = "plot", plot.caption.position = "plot",
        # change the size of aixs titles and text
        axis.title = element_text(size=16), axis.text = element_text(size = 14))