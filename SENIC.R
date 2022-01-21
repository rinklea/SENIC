#Reading the csv file
senic = read.csv("SENIC.csv")
senic

#Creating the data frame
Senic<-data.frame(senic["Y"],senic["X1"],senic["X2"],senic["X3"],senic["X4"], senic["X5"],senic["X6"],senic["X7"],senic["X8"],senic["X9"], senic["X10"])
colnames(Senic) <- c("Length", "Age", "Infection_Risk", "Culturing_Ratio", "Routine_Xray", "Beds", "Medical_school", "Region", "Avg_Census", "Nurses", "Facilities")
Senic

#Histograms of the variables
par(mfrow=c(2,2))
hist(Senic$Length, main = "Histogram of Y", xlab = "Length of Stay")

hist(Senic$Age, main = "Histogram of X1", xlab = "Age")
hist(Senic$Infection_Risk, main = "Histogram of X2", xlab = "Infection Risk")
hist(Senic$Culturing_Ratio, main = "Histogram of X3", xlab = "Culturing Ratio")
hist(Senic$Routine_Xray, main = "Histogram of X4", xlab = "Routine X-ray")
hist(Senic$Beds, main = "Histogram of X5", xlab = "Beds")
hist(Senic$Medical_school, main = "Histogram of X6", xlab = "Medical School")
hist(Senic$Region, main = "Histogram of X7", xlab = "Region")
hist(Senic$Avg_Census, main = "Histogram of X8", xlab = "Average census")
hist(Senic$Nurses, main = "Histogram of X9", xlab = "Nurses")
hist(Senic$Facilities, main = "Histogram of X10", xlab = "Available Facilties")

#Boxplot of the variables
boxplot(Senic$Length, main = "boxplot of Y", xlab = "length of stay")
par(mfrow=c(2,2))

boxplot(Senic$Age, main = "boxplot of X1", xlab = "Age")
boxplot(Senic$Infection_Risk, main = "boxplot of X2", xlab = "Infection Risk")
boxplot(Senic$Culturing_Ratio, main = "boxplot of X3", xlab = "Culturing Ratio")
boxplot(Senic$Routine_Xray, main = "boxplot of X4", xlab = "Routine X-ray")
boxplot(Senic$Beds, main = "boxplot of X5", xlab = "Beds")
boxplot(Senic$Medical_school, main = "boxplot of X6", xlab = "Medical School")
boxplot(Senic$Region, main = "boxplot of X7", xlab = "Region")
boxplot(Senic$Avg_Census, main = "boxplot of X8", xlab = "Average census")
boxplot(Senic$Nurses, main = "boxplot of X9", xlab = "Nurses")
boxplot(Senic$Facilities, main = "boxplot of X10", xlab = "Available Facilties")

#Scatter plot
pairs(senic)

#Correlation Matrix
library(corrplot)
cor(Senic)
corrplot(cor(Senic))

####################### Fit a regression model with all of the predictors ###################

full.lmfit <- lm(Y ~ X1+X2+X3+X4+X5+X6+X7+X8+X9+X10, data=senic)
summary(full.lmfit)

################ Added-Variable Plots ######################

library(car)
avPlots(full.lmfit)

#Model fitting
lm1 <- lm(Y ~ X1, data=senic)
summary(lm1)
lm2 <- lm(Y ~ X1+X2, data=senic)
summary(lm2)
lm3 <- lm(Y ~ X1+X2+X3, data=senic)
summary(lm3)
lm4 <- lm(Y ~ X1+X4+X5, data=senic)
summary(lm4)
lm5 <- lm(Y ~ X1+X2+X3+X5, data=senic)
summary(lm5)
lm6 <- lm(Y ~ X1+X2+X7+X8, data=senic) 
summary(lm6)
lm7 <- lm(Y ~ X1+X3+X7+X8, data=senic)
summary(lm7)
lm8 <- lm(Y ~ X1+X2+X7+X8+X9, data=senic)
summary(lm8)
lm9 <- lm(Y ~ X1+X2+X4+X7+X8+X9, data=senic) 
summary(lm9)
lm10 <- lm(Y ~ X1+X3+X7+X8+X9+X10, data=senic)
summary(lm10)
lm11 <- lm(Y ~ X1+X2+X6+X8+X9+X10, data=senic)
summary(lm11)
#SELECTED MODEL 
lm12 <- lm(Y ~ X1+X2+X4+X5+X7+X8+X9, data=senic)
summary(lm12)

#################### Model Selection (Step wise Regression) #####################

#### Install packages for the model selection ####

install.packages("leaps")
install.packages("HH")
install.packages("StepReg")

#### Load HH, leaps, and StepReg packages ####

library(leaps)
library(HH)
library(StepReg)
par(mfrow=c(2, 2))

#### Stepwise Regression ####

#### Adjusted R2 ####

b = bestsubset(data=senic,y="Y",select="adjRsq",best=5)
print(b)
stepwise(data=senic,y="Y",select="adjRsq")
plot(b[,1:2])

#### Cp ####

b = bestsubset(data=senic,y="Y",select="CP",best=5)
print(b)
stepwise(data=senic,y="Y",select="CP")
plot(b[,1:2])

#### AIC ####

b = bestsubset(data=senic,y="Y",select="AIC",best=5)
print(b)
stepwise(data=senic,y="Y",select="AIC")
plot(b[,1:2])

#### BIC ####

b = bestsubset(data=senic,y="Y",select="BIC",best=5)
print(b)
stepwise(data=senic,y="Y",select="BIC")
plot(b[,1:2])

####Final model
reduced.lmfit <- lm(Y ~ X1+X2+X4+X5+X7+X8+X9, data=senic) 
summary(reduced.lmfit)

######## Regression Diagnostics ############

res <- rstudent(reduced.lmfit)
fitted.y <- fitted(reduced.lmfit)

######## Residual Plots ##########

par(mfrow=c(2,2))
plot(res ~ senic$X1, xlab="X1", ylab="Residual", main="Residuals vs. X1")
abline(h=0)
plot(res ~ senic$X2, xlab="X2", ylab="Residual", main="Residuals vs. X2")
abline(h=0)
plot(res ~ senic$X4, xlab="X4", ylab="Residual", main="Residuals vs. X4")
abline(h=0)
plot(res ~ senic$X5, xlab="X4", ylab="Residual", main="Residuals vs. X5")
abline(h=0)
plot(res ~ senic$X7, xlab="X7", ylab="Residual", main="Residuals vs. X7")
abline(h=0)
plot(res ~ senic$X8, xlab="X8", ylab="Residual", main="Residuals vs. X8")
abline(h=0)
plot(res ~ senic$X9, xlab="X9", ylab="Residual", main="Residuals vs. X9")
abline(h=0)


plot(res ~ fitted.y, xlab="Fitted value", ylab="Residual", main="Residuals vs. Fitted Values")
abline(h=0)

######### Normality ###########

qqnorm(res);
qqline(res)
shapiro.test(res)

######### Constancy of Error Variances #########
library(lmtest) 
bptest(reduced.lmfit)


#######Influential observations#######
install.packages("olsrr")
library(olsrr)

# 1. DFFITS 

ols_plot_dffits(reduced.lmfit)

# 2. Cook's D

ols_plot_cooksd_chart(reduced.lmfit)

# 3. DFBETAS 

ols_plot_dfbetas(reduced.lmfit)

######### Multicollinearity ##########

library(car)
vif(reduced.lmfit)

######### Transformation #########
library(EnvStats)

boxcox.summary <- boxcox(reduced.lmfit, optimize=TRUE)
lambda <- boxcox.summary$lambda
lambda

trans.Y <- senic$Y^lambda

senic <- cbind(senic,trans.Y)
senic


######### Re-fitting a model using the transformed response variable. ##########

boxcox.lmfit <- lm(trans.Y ~ X1 + X2 + X4 + X5+ X7+ X8 +X9, data=senic)
summary(boxcox.lmfit)

boxcox.res <- rstudent(boxcox.lmfit)

boxcox.fitted.y <- fitted(boxcox.lmfit)

######## Residual Plots ##########

par(mfrow=c(2,2))
plot(boxcox.res ~ senic$X1, xlab="X1", ylab="Residual", main="Residuals vs. X1")
abline(h=0)
plot(boxcox.res ~ senic$X2, xlab="X2", ylab="Residual", main="Residuals vs. X2")
abline(h=0)
plot(boxcox.res ~ senic$X4, xlab="X4", ylab="Residual", main="Residuals vs. X4")
abline(h=0)
plot(boxcox.res ~ senic$X5, xlab="X5", ylab="Residual", main="Residuals vs. X5")
abline(h=0)
plot(boxcox.res ~ senic$X7, xlab="X7", ylab="Residual", main="Residuals vs. X7")
abline(h=0)
plot(boxcox.res ~ senic$X8, xlab="X8", ylab="Residual", main="Residuals vs. X8")
abline(h=0)
plot(boxcox.res ~ senic$X9, xlab="X9", ylab="Residual", main="Residuals vs. X9")
abline(h=0)


plot(boxcox.res ~ boxcox.fitted.y, xlab="Fitted value", ylab="Residual", main="Residuals vs. Fitted Values")
abline(h=0)

######### Normality ###########

qqnorm(boxcox.res);
qqline(boxcox.res)
shapiro.test(boxcox.res)

######### Constancy of Error Variances #########
library(lmtest) 
bptest(boxcox.lmfit)

# 1. DFFITS 

ols_plot_dffits(boxcox.lmfit)

# 2. Cook's D

ols_plot_cooksd_chart(boxcox.lmfit)

# 3. DFBETAS 

ols_plot_dfbetas(boxcox.lmfit)

######### Multicollinearity ##########

library(car)
vif(boxcox.lmfit)

######### Final Model ##########

final.lmfit <- boxcox.lmfit
summary(final.lmfit)
anova(final.lmfit)

#F-test for overall hypothesis
alpha<-0.05
f_value<-qf(0.95, 7, 105, lower.tail=TRUE)
f_value

#t-tests for individual regression coefficients
t_value<-qt(0.975, 105)
t_value
