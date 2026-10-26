

head(ashford_matches)
str(ashford_matches)
summary(ashford_matches)
ashford_matches$goal_conceded,1,0
)
ashford_matches$win <- ifelse(
  ashford_matches$goals_scored>
ashford_matches$goals_conceded,1,0
)
table(ashford_matches$win)

# fit binomail regression model
glm_ashford <- glm(
  win ~ home_away + opponent_rank,
  family = binomial,
  data = ashford_matches
)
summary(glm_ashford)

# confidence intervals and odd ratios
confint(glm_ashford)

# test of signifance
drop1(glm_ashford, test= 'Chisq')

# fit simpler model
glm_ashford_2 <- glm(win ~ opponent_rank,
family= binomial,
data= ashford_matches)
summary(glm_ashford_2)
drop1(glm_ashford_2, test='Chisq')

