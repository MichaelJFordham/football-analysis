# to allow us to install packages from github:
#install.packages("devtools")

# a meta package that contains packages for data cleaning, analysis and visualisation
#install.packages("tidyverse")

# to save xlsx files
#install.packages("xlsx")

# to install worldfootballR
#devtools::install_github("JaseZiv/worldfootballR", ref = "main")

library(worldfootballR)
library(tidyverse)
library(xlsx)

# now let's get our season team shooting data from FBref:
prem_2022_shooting <- fb_season_team_stats(country = "ENG", gender = "M", season_end_year = "2023", tier = "1st", stat_type = "shooting")

# get our data ready for plotting
prem_2022_shooting %>% 
  # filter out only the team shooting data, not their opponents also
  filter(Team_or_Opponent == "team") %>%
  # start plotting:
  ggplot(aes(x= xG_Expected, y= Gls_Standard)) +
  # add a line through the plot with slope =  1 and the yintercept = 0
  geom_abline(slope = 1, intercept = 0, colour = "red", linetype=2) +
  # we want to make it a scatter plot
  geom_point(size=6, colour="midnightblue", fill="midnightblue", alpha = 0.4, shape=21) +
  # lets also add team name labels
  ggrepel::geom_text_repel(aes(label = Squad), colour = "midnightblue", size=5) + 
  # limit the x and y-axis to start at 10 and finish at 100
  scale_x_continuous(limits = c(0,40), name = "xG") +
  scale_y_continuous(limits = c(0,40), "Actual Goals") +
  # create a title and subtitle - all plots should have this
  ggtitle("DID TEAMS SCORE AS EXPECTED?",
          subtitle = "Teams above the dashed line exceeded their xG for the\nseason, while teams below didn't") +
  # apply a pre-programmed general theme:
  theme_minimal() +
  # but then we can customise our plot even more - first we make the background black:
  # change the title and subtitle format
  theme(plot.title = element_text(size=28, face="bold"), plot.subtitle = element_text(size=22, colour="grey30"),
        # and change where the plot is aligned - in this case it's left-aligned
        plot.title.position = "plot", plot.caption.position = "plot",
        # change the size of aixs titles and text
        axis.title = element_text(size=16), axis.text = element_text(size = 14))