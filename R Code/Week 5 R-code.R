# week 5 - poisson model for ashford goals scored
# (log-linear model + overdispersion, from week 5 notes)

matches <- read.csv("ashford_matches.csv")
matches$home_away <- factor(matches$home_away, levels = c("Away", "Home"))

# look at the data first
mean(matches$goals_scored)
var(matches$goals_scored)   # bigger than the mean - might be overdispersed
tapply(matches$goals_scored, matches$home_away, mean)

# plots of the data
barplot(table(matches$goals_scored), xlab = "Goals scored", ylab = "Number of matches")

boxplot(goals_scored ~ home_away, data = matches, xlab = "Home/Away", ylab = "Goals scored")

plot(matches$opponent_rank, matches$goals_scored, pch = ifelse(matches$home_away == "Home", 1, 2),
     xlab = "Opponent rank", ylab = "Goals scored")
legend("topleft", c("Home", "Away"), pch = c(1, 2))

plot(matches$opponent_rank, log(matches$goals_scored + 1),
     xlab = "Opponent rank", ylab = "log(Goals scored + 1)")

# poisson model with log link
g1 <- glm(goals_scored ~ home_away + opponent_rank, family = poisson, data = matches)
summary(g1)
exp(coef(g1))   # multiplicative effect on mean goals

# residual deviance compared with its df
deviance(g1)
df.residual(g1)

# residual plots like the tortoise example
plot(fitted(g1), rstandard(g1), xlab = "Fitted values", ylab = "Standardised Deviance Residuals")
plot(fitted(g1), residuals(g1, type = "pearson"), xlab = "Fitted values", ylab = "Pearson Residuals")

# overdispersion - estimate phi
phi <- sum(residuals(g1, type = "pearson")^2) / g1$df.residual
phi
summary(g1, dispersion = phi)

# same thing with quasipoisson
g1q <- glm(goals_scored ~ home_away + opponent_rank, family = quasipoisson, data = matches)
summary(g1q)

# compare std errors
cbind(poisson = sqrt(diag(vcov(g1))), quasi = sqrt(diag(vcov(g1q))))