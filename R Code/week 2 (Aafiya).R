setwd("C:/Users/Admin/OneDrive - Queen Mary, University of London/Stats modelling/Group Project/Files")
ashford_matches <- read.csv("ashford_matches.csv", header = T)
league_players <- read.csv("league_players.csv", header = T)

head(ashford_matches)
head(league_players)

# fit for league players first: predicting bmi based on other variables
# left out team because its categorial and injury because its unlikely an injury affects bmi,
# i'd assume its the opposite

model_players <- lm(bmi ~ age + minutes_played + training_load + prev_injuries, data = league_players)
summary(model_players)

#all p values are greater than 0.05, therefore it is not statistically significant
# none of these variables have a statistically significant relationship with bmi

plot(model_players)

plot(model_players$fitted.values, rstandard(model_players),
     xlab = 'Fitted values',
     ylab = 'Standardised residual',
     main = 'Residuals vs fitted for BMI model')
     abline(h=0, lwd =2)
     
# h = 0 draws line at y = 0 means residual at this point is zero
     

qqnorm(rstandard(model_players))
qqline(rstandard(model_players), lwd = 2)


# fit the ashford matches model

model_matches <- lm(goals_scored ~ home_away + goals_conceded + opponent_rank, data = ashford_matches)
summary(model_matches)

plot(model_matches$fitted.values, rstandard(model_matches),
     xlab = 'Fitted values',
     ylab = 'Standardised resisduals',
     main = 'Residuals vs fitted for Goals scored model')
abline(h = 0, lwd = 2)

qqnorm(rstandard(model_players))
qqline(rstandard(model_players), lwd = 2)
