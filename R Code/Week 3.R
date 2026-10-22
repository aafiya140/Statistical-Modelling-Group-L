

# Week 3: Introduction to Generalised Linear Models
# Odds ratios, Wald tests, deviance and likelihood ratio tests


# 1. Load the datasets

setwd("C:/Users/Admin/OneDrive - Queen Mary, University of London/Stats modelling/Group Project/Files")

ashford_matches <- read.csv("ashford_matches.csv", header = T)
league_players <- read.csv("league_players.csv", header = T)

head(ashford_matches)
head(league_players)


# 2. Explore the datasets

str(league_players)
summary(league_players)

str(ashford_matches)
summary(ashford_matches)


# 3. Identify variable types

# League players:
# team: categorical
# position: categorical
# age: continuous/numerical
# minutes_played: numerical
# training_load: ordinal score (1-5)
# prev_injuries: count
# bmi: continuous/numerical
# injured: binary (0 = not injured, 1 = injured)

# Ashford matches:
# home_away: categorical
# goals_scored: count
# goals_conceded: count
# opponent_rank: numerical rank

# A binomial GLM is suitable for a binary response such as injured.
# A Poisson GLM may be suitable for a count response such as goals_scored,
# subject to checking model assumptions and fit.


# 4. Examine the injury outcome

table(league_players$injured)
prop.table(table(league_players$injured))

# Examine categorical predictors
table(league_players$position)
table(league_players$team)

# Examine home and away fixtures
table(ashford_matches$home_away)


# 5. Fit a simple logistic regression model
# Response: injured
# Explanatory variable: age
# H0: beta_age = 0
# H1: beta_age != 0

glm_league_week3 <- glm(injured ~ age,
                        family = binomial(link = "logit"),
                        data = league_players)

summary(glm_league_week3)


# 6. Calculate the odds ratio for age
# Following the lecture example, exp(beta_age) gives the odds ratio
# for a one-year increase in age.

odds_ratio_age <- exp(coef(glm_league_week3)["age"])
odds_ratio_age

# 95% confidence interval for the odds ratio
exp(confint(glm_league_week3)["age", ])


# 7. Wald test for age
# The coefficient table reports the estimate, standard error,
# z-statistic and p-value.

summary(glm_league_week3)$coefficients["age", ]


# 8. Fit the intercept-only model

glm_league_null <- glm(injured ~ 1,
                       family = binomial(link = "logit"),
                       data = league_players)

# Compare null and residual deviance
glm_league_null$deviance
glm_league_week3$deviance

# Reduction in deviance after adding age
glm_league_null$deviance - glm_league_week3$deviance


# 9. Likelihood ratio test (LRT)
# Compare the intercept-only model with the model including age.

anova(glm_league_null,
      glm_league_week3,
      test = "Chisq")


# 10. Examine the contribution of predictors together
# This is an extension of the simple lecture example.

glm_league_week3_multiple <- glm(
  injured ~ age + prev_injuries + bmi,
  family = binomial(link = "logit"),
  data = league_players
)

summary(glm_league_week3_multiple)


# Adjusted odds ratios
exp(coef(glm_league_week3_multiple))

# 95% confidence intervals for adjusted odds ratios
exp(confint(glm_league_week3_multiple))

# Wald tests for individual coefficients
summary(glm_league_week3_multiple)$coefficients


# LRT comparing the null model with the multiple-predictor model
anova(glm_league_null,
      glm_league_week3_multiple,
      test = "Chisq")

# LRTs assessing each predictor's contribution
drop1(glm_league_week3_multiple, test = "Chisq")
