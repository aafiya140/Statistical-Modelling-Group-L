**Week 5: Poisson regression on Ashford Matches**

**Ashford Matches:**

Used R to fit a Poisson GLM with a log link to see if goals scored can be explained by home or away and opponent's rank. Goals scored is a count, so a Poisson model makes more sense than the normal linear regression from Week 2, which predicted negative goals for the intercept. The log link means the fitted mean can't be negative.
I left out goals conceded because it wasn't significant in the Week 2 model.

Before fitting I checked the mean and variance of goals scored:

```
> mean(matches$goals_scored)
[1] 1.304348
> var(matches$goals_scored)
[1] 1.994203
> tapply(matches$goals_scored, matches$home_away, mean)
     Away      Home 
0.8695652 1.7391304 
```

The variance is bigger than the mean, which made me think the data could be overdispersed, so I checked this after fitting the model. Ashford score on average twice as many goals at home as away.

**Plots of the data:**

<img width="1186" height="893" alt="image" src="https://github.com/user-attachments/assets/6fddb0ee-36e9-4e75-a18b-ceaa7e58c1a4" />

Most matches have 0, 1 or 2 goals scored, with one match where Ashford scored 8.

<img width="1186" height="864" alt="image" src="https://github.com/user-attachments/assets/d0c586a7-49b7-41b8-891d-ee7e974bbf6d" />

Goals scored are higher at home than away. The 8 goal match shows up as an outlier in the home box.

<img width="1170" height="854" alt="image" src="https://github.com/user-attachments/assets/c4575121-d25f-4665-8efc-1b759c549074" />

<img width="1154" height="815" alt="image" src="https://github.com/user-attachments/assets/c5b5f22c-8fc0-426d-8426-3a0c2b0b32c0" />

Goals scored seem to increase as the opponent's rank increases (weaker opponents).

**Model:**

```
Coefficients:
              Estimate Std. Error z value Pr(>|z|)   
(Intercept)   -0.89880    0.37052  -2.426  0.01528 * 
home_awayHome  0.69315    0.27386   2.531  0.01137 * 
opponent_rank  0.05435    0.01939   2.802  0.00507 **

(Dispersion parameter for poisson family taken to be 1)

    Null deviance: 64.844  on 45  degrees of freedom
Residual deviance: 49.785  on 43  degrees of freedom
AIC: 133.43
```

```
> exp(coef(g1))
  (Intercept) home_awayHome opponent_rank 
    0.4070565     2.0000000     1.0558519 
```

Both home/away and opponent rank have p < 0.05 so they are both statistically significant explanatory variables.

- Playing at home multiplies the expected number of goals by exp(0.693) = 2, so Ashford are expected to score twice as many goals at home as away.
- Each place lower the opponent is in the table multiplies the expected goals by exp(0.0544) = 1.056, about a 5.6% increase per place. Going from playing the 1st placed team to the 24th placed team multiplies expected goals by exp(0.0544 × 23) ≈ 3.49.
- The intercept, exp(-0.899) = 0.41, would be the expected goals away against an opponent ranked 0, which isn't possible, so it doesn't have a real meaning on its own.

**Goodness of fit:**

The residual deviance is 49.785 on 43 degrees of freedom. 1 - pchisq(49.785, 43) = 0.22, so there is no evidence the model fits badly.
But the fitted values are all small (between about 0.43 and 3), and the Week 4 notes say the χ² approximation for the deviance works best when fitted counts are above 5, so this test should be treated with some caution.

**Residual plots:**

<img width="1138" height="776" alt="image" src="https://github.com/user-attachments/assets/bbd284e8-26ab-4741-abd8-e49d3feaa561" />


The points are scattered above and below zero without a strong pattern or funnel shape. The residuals form lines because goals are whole numbers and the fitted values are small. The 8 goal match (home, opponent rank 24) has the largest residual, about 2.6 standardised deviance residual, because the model only predicted 3 goals. Two home matches with 0 goals against weaker opponents (ranks 15 and 18) also have residuals of around -2. Nothing goes much past 3, so there are no extreme points.

**Overdispersion:**

```
> phi
[1] 0.9904079
```

φ̂ = X² / residual df = 0.99, which is very close to 1, so there is no overdispersion once home/away and opponent rank are in the model. The variance being bigger than the mean earlier was because it ignored home/away and opponent rank. Some of the spread in goals is explained by those two variables.

I also refitted with quasipoisson to check:

```
Coefficients:
              Estimate Std. Error t value Pr(>|t|)   
(Intercept)   -0.89880    0.36874  -2.437  0.01900 * 
home_awayHome  0.69315    0.27254   2.543  0.01466 * 
opponent_rank  0.05435    0.01930   2.816  0.00732 **

(Dispersion parameter for quasipoisson family taken to be 0.99041)
```

```
                 poisson      quasi
(Intercept)   0.37052137 0.36874045
home_awayHome 0.27386094 0.27254462
opponent_rank 0.01939448 0.01930126
```

The estimates are the same and the standard errors barely change (they are multiplied by √0.99). Both variables are still significant at the 5% level using the t-test. So the quasipoisson adjustment isn't needed and the ordinary Poisson model is fine.

**Decisions:**

- Used a Poisson GLM instead of normal linear regression because goals scored is a count.
- Kept the 8 goal match in the data. It has the largest residual but it isn't extreme enough to remove.
- Didn't use an offset because every match is the same length, so there is no exposure variable.
- Kept the Poisson model rather than quasipoisson since φ̂ ≈ 1.

**Conclusion:**

The Poisson model fits the data reasonably well, with no evidence of overdispersion (φ̂ = 0.99). Home/away and opponent rank are both significant. Ashford are expected to score twice as many goals at home, and about 5.6% more goals for each place lower their opponent is in the table. This agrees with the Week 2 linear model, but the Poisson model is more appropriate because it can't predict negative goals.
