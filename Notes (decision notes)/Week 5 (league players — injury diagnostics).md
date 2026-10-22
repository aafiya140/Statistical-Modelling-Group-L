The aim of this work was to check how well our logistic regression model fits the league players data and identify any unusual observations that could influence the results.

The dataset is league_players.csv. The response variable is injured, where 0 means the player was not injured and 1 means the player was injured.

1. Diagnostic plots for the injury model

R code

# Set up a layout for four diagnostic plots
par(mfrow = c(2, 2))

# Produce the diagnostic plots
plot(injury_model)

# Reset the plot layout
par(mfrow = c(1, 1))

What the code does

par(mfrow = c(2, 2)) arranges four plots in a 2-by-2 layout.

plot(injury_model) automatically produces diagnostic plots for the fitted logistic regression model.

par(mfrow = c(1, 1)) resets the layout so future plots appear individually.

What the four plots show

1. Residuals vs Fitted: Helps identify unusual residual patterns and possible problems with the model fit.

2. Q–Q Residuals: Helps highlight unusual residuals. Normality is not a standard assumption of logistic regression, so this plot must be interpreted carefully.

3. Scale–Location: Shows how the spread of residuals changes across fitted values. A changing spread is not automatically a problem for logistic regression.

4. Residuals vs Leverage: Helps identify observations with unusual residuals and high leverage that may have an influence on the fitted model.

2. Cook's distance plot

R code

# Calculate Cook's distance for each observation
cooks <- cooks.distance(injury_model)

# Plot Cook's distance for all observations
plot(
  cooks,
  type = "h",
  main = "Cook's Distance for Injury GLM",
  xlab = "Observation",
  ylab = "Cook's distance"
)

What the code does

cooks.distance(injury_model) calculates a measure of how much each observation may influence the fitted model.

type = "h" displays vertical lines for each observation.

main sets the plot title.

xlab and ylab label the horizontal and vertical axes.

Interpretation

The plot shows Cook's distance for each of the 620 players. Observations with larger values may have a greater influence on the model's estimates.

The five largest Cook's distances in our analysis were:

Observation

Cook's distance

546

0.0295

169

0.0239

238

0.0235

101

0.0221

281

0.0191

These observations were flagged for further investigation. They should not automatically be removed, as they may represent valid players in the dataset.
The diagnostic plots provide a way to assess the logistic regression model and identify potentially influential observations. The Pearson dispersion statistic was approximately 1.08, and the model converged successfully.
