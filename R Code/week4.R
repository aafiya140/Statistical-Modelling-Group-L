setwd("C:/Users/Admin/OneDrive - Queen Mary, University of London/Stats modelling/Group Project/Files")
league_players <- read.csv("league_players.csv", header = T)

head(league_players)

# fit glm model with injured as the response variable and age, previous injuries and bmi as the explanatory variables

glm_league <- glm(injured ~ age + prev_injuries + bmi, family = binomial, data= league_players)

summary(glm_league)

confint(glm_league)
exp(confint(glm_league))

drop1(glm_league, test = "Chisq")

glm_league_2 <- glm(injured ~ age + prev_injuries, family = binomial, data = league_players)
summary(glm_league_2)

drop1(glm_league_2, test = "Chisq")

glm_league_workload <- glm(injured ~ age + prev_injuries + minutes_played + training_load, family = binomial, data = league_players)
summary(glm_league_workload)
drop1(glm_league_workload, test = "Chisq")

glm_league_final <- glm(injured ~ age + prev_injuries + training_load, family = binomial, data = league_players)
summary(glm_league_final)
drop1(glm_league_final, test = "Chisq")
