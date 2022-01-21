Introduction:

The primary goal of the SENIC Project (Study on the Efficacy of Nosocomial Infection Control) was to assess if infection monitoring and control systems have lowered hospital-acquired infection rates in US hospitals. This project aims to create and test a statistical regression model to predict hospital stays for patients in the United States using the SENIC's project data.

It's helpful to understand the data columns before diving into the real problem to avoid misunderstanding later on. Now, let us first study the data columns (which have already been provided by the firm) to gain a general idea.

•	Length of Stay (Y)
 Average length of stay of all patients in hospital (in days)

• Age (X1)
Average age of patients (in years). 
 
• Infection Risk (X2)
Estimated probability of acquiring infection in hospital (percent). 
 
• Routine Culturing Ratio (X3)
Ratio  of  number  of  cultures  performed  to  the  number  of  patients  without  signs  or 
symptoms of hospital-acquired infection, times 100. 
 
• Routine X-ray Ratio (X4)
Ratio of number of X-rays performed to number of patients without signs or symptoms 
of pneumonia, times 100. 
 
• Number of Beds (X5)
number of beds in hospital during study period. 
 
• Medical School (X6)
Indicator of whether the hospital is associated with a medical school (1 = Yes, 2 = No). 
 
• Region (X7)
Indicator of the geographic region for hospital (1 = NE, 2 = NC, 3 = S, 4 = W). 
 
• Average Census (X8)
number of patients per day in hospital during study period. 

• Number Nurses (X9)
number  of  full-time  equivalent  registered  and  licensed  practical  nurses  during  study 
period (number of full time plus one half the number of part time). 
 
• Available Facilities (X10)
Percent of 35 potential facilities and services that are provided by the hospital. 

This data collection is made up of 113 hospitals chosen at random. The 11 variables listed above apply to each hospital. Our response/dependent variable is length of stay, whereas the others are independent variables. Although no missing values were detected in this data set, some scaling was determined to be essential for the purposes of our research.

Exploratory Data Analysis:

The histogram for our response variable, length of stay, is slightly right-skewed. 
It is observed that age, infection risk, routine x-ray, and the number of available facilities is normally distributed. Culturing ratio, number of beds, region, number of nurses, and the average census distribution is highly right-skewed. This means that the data for these variables is not centered around the median. 
   

The box plot of the response variable shows that the distribution of the hospital stays is relatively normal with an average close to 10 days and the highest frequency on the record is from the group with 8–10 days of hospital stays.

It can be observed that the distribution of age, infection risk, routine x-ray, and number of facilities is normal with an average of 54%, 4.6%, 80%, and 40% respectively in US. Several outliers were spotted for age, culturing ratio, average census, the number of beds and nurses. The box plots also showed that the distribution of census, culturing ratio, region, and the number of nurses and beds is highly right-skewed. 

Scatter plot:

The sctter plots show the relationships between the predictors themselves. It seems that some predictors are correlated to each other. 
We can observe that predictors X5, X8, X9, and X10 are strongly correlated to each other. Variables X2 and X3 are correlated too.
 
Added-variable plots:

The added-variable plots provide the regression lines for the relationships between the response variable and the predictor variables. The plots for the response variable against culturing ratio, medical school, and available facilities show regression lines with data points scattered far from it; this means that there are not strong linear relationships between the response variable and these predictor variables. The plots for the response variable against age, infection risk, routine x-ray, beds, region, average census, and the number of nurses variables show regression lines that closely follow the data points; this means that there might be strong linear relationships between the response variable and these predictor variables.
  
Correlation Matrix:

It can be observed from the correlation matrix that correlation between certain predictors exists in our model.

 
Model fitting:
 

Looking at the summary of the full model, variables with p-values greater than 0.1 were removed. So, variables X3, X6 and X10 were removed from our model. The p-value of X5 was very close to 0.1 so I had to investigate it further.

After that, I fitted several models with different number of predictor variables and the model with 7 variables i.e. X1, X2, X4, X5, X7, X8, and X9 seems to give the highest adjusted R-squared value i.e. 0.5966. 

Model Selection:

Next, I performed model selection. I ran the stepwise function in order to select the best variables based on the adjusted R^2, the CP, the AIC, and the BIC. 
To assess the quality of fit that our model has for the data, we looked at AIC, BIC, adj. R2 , and Mallow’s Cp. The values of these can be seen below: 

AIC = 166.5292

BIC = 54.98371

Adj. R^2 = 0.59662

Mallow’s CP =  6.48305

We found that the best variables were age, infection risk, routine x-ray, region, average census and the number of nurses and beds.
 
The adjusted R^2 plot, Cp plot, AIC plot, and BIC plot indicates that seven predictor variables should be included in our model because that is where the points in the plot begin to level out. 

Final model:

Y= 3.250675+ 0.078936X1+ 0.435866X2+ 0.013536 X4 -0.006262 X5 -0.571442X7+ 0.016573X8 -0.006059X9

Multiple R-squared:  0.6218

Adjusted R-squared:  0.5966

I decided to keep this as the final model and to move forward with assumption checking. 

Model Diagnostics:

a.	Linear Assumption:

Looking at our jackknifed residual vs. fitted value plot, we can see that our model meets the linearity assumption as the residuals are randomly distributed around the fitted values. Similarly, the jackknifed residual vs. predictor value plots also indicates that the linearity assumption is met as the residuals are randomly distributed around the predictor variables. That means our model is a good fit for our data.

b.	Normality

The normal probability plot indicates that the data nearly forms a normal distribution because the data points mostly align with only some slight deviation near the lowest and highest values. In the Shapiro-Wilk test, the null hypothesis states that the error terms are normally distributed while the alternative hypothesis states that the error terms are not normally distributed. Our decision rule states that if the test statistic is small and the p-value is less than the significance level (alpha = 0.05), then we must reject the null hypothesis. If the test statistic is large and the p-value is greater than the significance level, we must fail to reject the null hypothesis. 

We calculated a test statistic of 0.87698 and p-value of 3.23e-08. Thus, we can reject the null hypothesis and conclude that the error terms are not normally distributed.

c.	Homoscedasticity Assumption

In the Breusch-Pagan test, the null hypothesis states that there is constant error variance and the alternative hypothesis states that there is not constant variance. The decision rule is that if the p-value is less than the significance level of 0.05, we will reject the null hypothesis and conclude that the error variance is not constant. If the p-value is greater than the significance level of 0.05, we will fail to reject the null hypothesis and conclude that the error variance is constant. 

We calculated a test statistic of 7.9695 and a p-value of 0.3353 so we fail to reject the null hypothesis and conclude that the error terms are constant. 

d.	Influential Observations:

From the graphs, we can see that there are many influential observations. The Cook’s D plot shows that there are many outliers outside of the threshold of 0.035. Some of these major outliers include 8, 10, 43, 46, 47, 48, 63, 81, 112, etc. The DFFITS plot also indicates that there are many outliers both above and below the threshold of 0.53, including 8, 47, 81, 106, 112, etc.

e.	Multicollinearity
 
The values obtained from the variance inflation factor analysis indicate that multicollinearity is a major problem in our final model. This is because the VIF values for X5 and X8 are more than 10. 

Remedial Actions/Transformations :

Based on our assumption checking, we found that our model satisfied the linearity and the homoscedasticity assumptions. Therefore we don’t have to use the method of Weighted Least Squares (WLS). However, a box-cox transformation is required to make the model normal. The box-cox transformation will not correct the multicollinearity discovered earlier. Using the box-cox function in R, the lambda value needed can be determined. 
 

With a lambda value of -1.396303, the response variable can be transformed and a new model created. 


Model Diagnostics for Transformed Model :

To be sure that the model was truly appropriate for the data, the assumptions for linearity, normality, homoscedasticity, outlier/influential points, and multicollinearity had to be checked again with the transformed values.

a.	Linearity

To assess the linearity of our chosen transformed model we analyzed the scatter plots between the jackknifed residual and fitted values, we can see that the model meets the linearity assumption as the residuals are randomly distributed around the fitted values. Similarly, the jackknifed residual vs. predictor value plots for the transformed model also indicates that the linearity assumption is met as the residuals are randomly distributed around the predictor variables.

b.	Normality

The normal probability plot of the transformed model indicates that the data nearly forms a normal distribution because the data points mostly align with only some slight deviation near the lowest and highest values. 

In the Shapiro-Wilk test, the null hypothesis states that the error terms are normally distributed while the alternative hypothesis states that the error terms are not normally distributed. Our decision rule states that if the test statistic is small and the p-value is less than the significance level (alpha = 0.05), then we must reject the null hypothesis. If the test statistic is large and the p-value is greater than the significance level, we must fail to reject the null hypothesis. 
For our transformed model:

We calculated a test statistic of 0.98873 and p-value of 0.473. Thus, we fail to reject the null hypothesis and conclude that the error terms are normally distributed. 

c.	Homoscedasticity Assumption

In the Breusch-Pagan test, the null hypothesis states that there is constant error variance and the alternative hypothesis states that there is not constant variance. The decision rule is that if the p value is less than the significance level of 0.05, we will reject the null hypothesis and conclude that the error variance is not constant. If the p value is greater than the significance level of 0.05, we will fail to reject the null hypothesis and conclude that the error variance is constant. 

For our transformed model:

We calculated a test statistic of 7.6815 and a p-value of 0.3615 so we fail to reject the null hypothesis and conclude that the error terms are constant.

d.	Influential Observations:

From the graphs, we can see that there are many influential observations. The Cook’s D plot shows that there are many outliers outside of the threshold of 0.035. Some of these major outliers include 10, 26, 43, 76, 81, 101, 106. The DFFITS plot also indicates that there are many outliers both above and below the threshold of 0.53, including  26, 43, 46, 76, 81,101, 106, etc.

e.	Multicollinearity

The values obtained from the variance inflation factor analysis indicate that multicollinearity is a major problem in our final model. This is because the VIF values for X5 and X8  are more than 10. The variance inflation factors did not change between the untransformed and transformed models. 
 
Did the transformation method work?

Our transformed regression model was able to solve the problem of normality. However, our model still has multicollinearity. In conclusion, our final model meets the assumption of linearity, normality, and homoscedasticity.

Final model:

Y = 7.142e-02 -3.339e-04 X1 -2.401e-03 X2 -5.376e-05 X4 + 1.233e-05 X5 + 3.787e-03 X7 - 4.755e-05 X8 + 1.558e-05 X9. 
 

F-test: (alpha = 0.05)

Hypothesis:

H0: All the regression coefficients = 0 vs Ha: not H0

F*= 21.05

f-value(0.95, 7, 105)= 2.098005

At a significance level of 0.05, F*>f-value, so we reject the null hypothesis and conclude that a model with the set of the seven predictor variables is a better fit than an only-intercept model. 

Also, p-value= 2.2e-16 which is less than 0.05, so we reject the null hypothesis and conclude that a model with the set of the seven predictor variables is a better fit than an only-intercept model.

Adjusted R2:

The adjusted R2 value is 0.5562, which means that about 56% (more than half) of the variation in the length of the stay in hospitals can be described by our model. 
Significance of individual predictors:

T-test: (alpha = 0.05)

t-value(0.975, 105) = 1.982815

We can see that the absolute value of the t-statistic for variables X4, X5, and X9 is less than the t-value at a significance level of 0.05. Hence, we cannot conclude that they are significant on the response variable. Also,

for X1, p-value= 0.0231<0.05 so we conclude that it is significant on the response variable. 

For X2, p-value= 9.67e-05<0.05 so we conclude that it is significant on the response variable. 

For X4, p-value= 0.1694>0.05 so we cannot conclude that it is significant on the response variable. 

For X5, p-value= 0.5082>0.05 so we cannot conclude that it is significant on the response variable. 

For X7, p-value= 2.79e-07<0.05 so we conclude that it is significant on the response variable. 

For X8, p-value= 0.0375<0.05 so we conclude that it is significant on the response variable. 

For X9, p-value= 0.1873>0.05 so we cannot conclude that it is significant on the response variable. 

Interpretation of Coefficients:

For unit increase in X1, the mean of probability distribution of Y changes by -3.339e-04
when X2, X4, X5, X7, X8, X9 are held constant. 

For unit increase in X2, the mean of probability distribution of Y changes by -2.401e-03
when X1, X4, X5, X7, X8, X9 are held constant. 

For unit increase in X4, the mean of probability distribution of Y changes by -5.376e-05
when X1, X2, X5, X7, X8, X9 are held constant. 

For unit increase in X5, the mean of probability distribution of Y changes by 1.233e-05
when X1, X2, X4, X7, X8, X9 are held constant. 

For unit increase in X7, the mean of probability distribution of Y changes by 3.787e-03
when X1, X2, X4, X5, X8, X9 are held constant. 

For unit increase in X8, the mean of probability distribution of Y changes by -4.755e-05
when X1, X2, X4, X5, X7, X9 are held constant. 

For unit increase in X9, the mean of probability distribution of Y changes by 1.558e-05
when X1, X2, X4, X5, X7, X8 are held constant. 

Conclusion:

I initially studied our data using visualizations like histograms, boxplots, scatterplots, correlation plots, and added-variance plots before developing a linear regression model. These plots helped me comprehend the skewness of our data and the relationship between the predictors and the response.

Following that, I fitted numerous regression models with various predictor variables to determine the relevance of certain variables based on their p-values. Then I ran model selection to see which variables the stepwise regression function in R recommended we maintain for our linear model. I kept seven predictor variables for the final model based on the AIC, BIC, Adj. R2, and Mallow's CP values.

I next examined the assumptions on this chosen model and discovered that it was not normal. As a result, I conducted a Box-Cox transformation on the altered model and questioned the assumptions. Overall, I found that the modified model was normal. According to the hypothesis test, all seven predictors are significant for the model.

With an adjusted R2 of 0.5562, I picked this changed model as my final model. Based on their age, infection risk, area, the routine x-ray, average census, and the number of nurses and beds, this model may be used to forecast the duration of stay of patients in hospitals.

On the other hand, the model might be improved by reducing collinearity between predictors.


