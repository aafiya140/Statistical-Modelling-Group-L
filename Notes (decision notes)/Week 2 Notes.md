**Week 2: Normal linear regression on League players and Ashford Matches**

**League Players:**

Used R to conduct a normal multiple linear regression model to determine if a players BMI could be predicted using their age, minutes played, training load, and previous injuries.
I left out Team because it is categorial data and left out Injury because I thought it would be highly unlikely a current injury would affect BMI, I’d expect BMI would affect injury but that is not what’s being tested here.

<img width="928" height="258" alt="image" src="https://github.com/user-attachments/assets/7cac0c44-e2e5-41d4-95db-d31d2b7224f8" />

 
The model intercept is 23.95, indicating the baseline of predicted BMI when all other predictors are zero. We can conclude that none of the explanatory variables were found to be statistically significant given that p>0.05 for all explanatory variables.
This means that age, minutes played, training load, and previous injuries all showed no significant relationship with BMI. Which may suggest BMI is independent of these factors.

**Plots:**

<img width="792" height="142" alt="image" src="https://github.com/user-attachments/assets/f4059cd7-ecd1-4d26-927f-2b3d53a89e3d" />

<img width="907" height="576" alt="image" src="https://github.com/user-attachments/assets/3c0eb522-e716-4e1b-9c35-be96ee84407e" />

 
The points are randomly scattered above and below zero line, with no obvious pattern or curvature. This confirms linearity assumption is met. There is no funnel shape so the constant variance assumption is met. There seems to be no extreme outliers that would influence the model


<img width="892" height="582" alt="image" src="https://github.com/user-attachments/assets/4bde39c1-c1fe-4a27-bd75-79bfdb8d425a" />


 
The points fall very close to the straight diagonal line across the entire range of values. The Normal Q-Q plot confirms that the normality assumptions of the linear regression are met. The residuals are approximately normally distributed.

**Conclusion**

The linear regression model satisfied all diagnostic assumptions including linearity, homoscedasticity and normality of residuals. However, none of the predictors (age, minutes played, training load, previous injuries) where statistically significant (all had p>0.05). This suggests that while the model is valid, these variables do not explain the variation in BMI. Suggests that BMI is influenced by factors which are not in this dataset.


**Ashford Matches:**

Used R to conduct a normal multiple linear regression model to determine if goals scored are explained by the explanatory variables home or away, goals conceded and opponent’s rank. 
<img width="804" height="403" alt="image" src="https://github.com/user-attachments/assets/83f61a0c-7c2d-495d-a7d7-3d97e8e2f0ad" />

 

Model predicts that the number of goals scored when Ashford are away, zero goals were conceded and the opponent rank is zero would be -0.23169 which isn’t possible because negative goals are impossible. Also a 0 opponent rank isn’t possible.
The p-values for home/away and opponent rank are less than 0.05 which suggests that they are statistically significant explanatory variables in the model.
Playing at home increases the expected goals scored by 0.95 compared to playing away, and each place worse than the opponents rank increases expected goals by 0.07.



**Plots:**

<img width="898" height="566" alt="image" src="https://github.com/user-attachments/assets/d4d0cafe-702b-4583-b4bf-16722b99bf0c" />

 

Overall scatter is mostly good. The points are generally scattered around the zero line without a strong curve or pattern. However, there is a point which sits way up at standardised residual at around 4.5 at a fitted value of 2.5. This means that there is one match where Ashford scored way more goals than the model predicted. The spread is reasonably constant across the fitted values and there is no funnel shape.



<img width="884" height="564" alt="image" src="https://github.com/user-attachments/assets/e6c47412-a229-463e-b296-a1538bad6160" />


 
The points fall very close to the straight diagonal line across the entire range of values. The Normal Q-Q plot confirms that the normality assumptions of the linear regression are met. The residuals are approximately normally distributed. 
In the tails there are a few upper points that pull slightly away from the line

**Conclusion:**
The linear regression model satisfies all diagnostic assumptions including linearity, homoscedasticity and normality of residuals with one outlier identified. The p-values for home away and opponent rank were both less than 0.05, making them statistically significant explanatory variables. The p value for goals conceded was greater than 0.05 so not a significant predictor. This suggests that playing at home and facing weaker components significantly increases the number of Ashford’s scores

