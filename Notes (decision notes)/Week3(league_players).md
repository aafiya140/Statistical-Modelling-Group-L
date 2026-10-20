# **Week 3 Analysis:**
League players

 <img width="878" height="514" alt="image" src="https://github.com/user-attachments/assets/42286349-ce28-4f43-8c3f-a408c9490d5a" />
<img width="514" height="148" alt="image" src="https://github.com/user-attachments/assets/3d49ba09-cde2-4412-b1a9-ac958eccf875" />

 

Drop in deviance: 594.71 – 547.20 = 47.51 on 3 degrees of freedom. This is a very large drop for 3 predictors, meaning the model is doing a good job at explaining injury risk compared to an intercept model only.
Dispersion parameter is 1: there is no overdispersion, the model fits the variance well

**The coefficients:**
This is binomial so we are looking at log odds, and we will exponentiate them to get odds ratio.
Age: Estimate = 0.109
-	This means for every 1 year older a player is, the log-odds of injury increase by 0.109
-	Odds ratio e^0.109≈1.115. For every extra year of age, the odds of being injured increases by approx. 11.5%. This is highly significant as p<0.001
-	95% CI : [1.05, 1.18]
Previous injuries: Estimate = 0.522
-	This means for every additional previous injury, the log odds increase by 0.522
-	Odds ratio e^0.522≈1.685. for every extra previous injury, the odds of being injured increase by 68.5%. This is highly significant (p<0.001)
-	95% CI : [ 1.41, 2.02]
BMI : Estimate = -0.057
-	Gets an odds ratio of 0.94. However, this is not statistically significant (p = 0.417). The data does not provide sufficient evidence to conclude that BMI is associated with injury risk one age and previous history are controlled for.
-	95% CI: [0.82, 1.08], we cannot be sure if BMI decreases risk (0.82), has no effect (1.0), or slightly increases risk (1.08)

 <img width="832" height="348" alt="image" src="https://github.com/user-attachments/assets/b2f9989c-c195-4a2f-9f2d-49281162285c" />


To assess the individual contribution of each predictor, a likelihood ratio test was performed using the drop in deviance analysis (drop1 with a chi-square test)

The results confirm that both age (LRT = 14.84, p<0.001) and previous injuries (LRT = 33.23, p<0.001) contribute significantly to the model. Dropping either variable causes a significant increase in residual deviance. However dropping bmi did not significantly increase the deviance (LRT = 0.057, p = 0.417)
AIC improved when we removed BMI (decreased from 555.20 to 553.86). This suggests that BMI does not add any predictive value once age and previous history are accounted for

<img width="850" height="501" alt="image" src="https://github.com/user-attachments/assets/4ef58a1f-335d-4f01-996f-1fe3a7007901" />


After removing BMI from the model, we can see the coefficients for age and previous injuries did not change much. Removing BMI also improved the AIC from 555.2 to 553.86, indicating a better, more parsimonious model. 


### **Now I fit the model adding other components (minutes played and training load)**
<img width="706" height="459" alt="image" src="https://github.com/user-attachments/assets/416b3554-ae66-425d-bc48-328f3cfc9ff3" />

 
I fitted another binomial GLM adding minutes played and training load. The AIC improved from 553.86 to 548.97 indicating a better model fit. 
In this model training load was a significant predictor (p= 0.006), and Odds ratio 1.36. meaning for every 1 unit increase there is a 36% increase in injury risk.
For minutes played it has a large p value suggesting minutes played isn’t statistically significant. Estimate is 0.0000867, meaning for every additional minute played there is essentially a zero% increase in injury risk.

<img width="835" height="363" alt="image" src="https://github.com/user-attachments/assets/5e1b59a0-5934-4bb8-a2e8-5562d49a68e5" />


Drop in deviance test was conducted. The results showed that minutes played did not significantly contribute to predicting injury. Removing it from the model decreased the AIC from 548.97 to 547.27, indicating a more parsimonious model. 



**Model with relevant explanatory variables:**
 
<img width="741" height="478" alt="image" src="https://github.com/user-attachments/assets/8f4501be-fa75-46f2-a707-ff92be2af208" />


 

The final model demonstrates that injury risk in this dataset is driven primarily by a player's age, their injury history, and their training load, rather than their match minutes. The analysis successfully identified the most parsimonious and robust set of predictors.
