# Assignment IEC7413 Spring 2025
# Problem I: AR Model Selection using AIC and Residual Diagnostics
# Author: Sonia Sofia
# Dataset: IncomeUK (Ecdat package)

# ============================================
# 1. Load required packages
# ============================================
# Note: install these in the console before running the script:
# install.packages("Ecdat")
# install.packages("dynlm")
# install.packages("lmtest")
# install.packages("tseries")

library(Ecdat)      # Contains the IncomeUK dataset
library(dynlm)      # For dynamic linear models
library(lmtest)     # For Ljung-Box test
library(tseries)    # For Jarque-Bera test

##NB: 
# Run in console if packages are not installed:
# install.packages("Ecdat")
# install.packages("dynlm")
# install.packages("lmtest") 
# install.packages("tseries")  
# ============================================
# 2. Load and inspect the data
# ============================================
data(IncomeUK)

# ============================================
# Extract the income variable
# ============================================
y <- IncomeUK[, "income"]

# ============================================
## First-difference to induce stationarity
# ============================================
dy <- diff(y)

# ============================================
## Summary Statistics and Stationarity
# ============================================
head(IncomeUK)
summary(IncomeUK)

# Set up the plotting area: 1 row, 2 columns
par(mfrow = c(1, 2))

# Plot original income
plot(y,
     main = "UK Disposable Income (1971–1985)",
     ylab = "Income (nominal £)",
     xlab = "Time",
     type = "l",
     col = "darkblue",
     lwd = 2)

# Plot differenced income
plot(dy,
     main = "First Difference of Income",
     ylab = "ΔIncome",
     xlab = "Time",
     type = "l",
     col = "darkred",
     lwd = 2)

# Income ranges from about £9,000 to £60,000. 
# The average is ~£30,600, but half earned less than £27,200 
# showing an upward skew with some high-income values. 
# The top 25% (£44,866) earn nearly three times more than 
# the bottom 25% (£15,820), suggesting a wide spread and a 
# clear upward trend.
# The left plot confirms this trend, while the right plot 
# shows that after differencing, the data becomes much more 
# stable. This confirms that differencing was the right step 
# before modeling.

# ============================================
## Question 1:
# ============================================
# Estimate AR(p) models (p = 1 to 5) using the first-order 
# difference of income
# All models should use the same number of observations

models <- list(
  AR1 = dynlm(dy ~ L(dy, 1)),
  AR2 = dynlm(dy ~ L(dy, 1:2)),
  AR3 = dynlm(dy ~ L(dy, 1:3)),
  AR4 = dynlm(dy ~ L(dy, 1:4)),
  AR5 = dynlm(dy ~ L(dy, 1:5))
)
# We fit five autoregressive (AR) models on the 
# first-differenced income data,ranging from AR(1) to AR(5).
# Each model includes lagged values of the dependent 
# variable and is stored in a list for easy comparison and 
# diagnostics.

# ============================================
## Question 2:
# ============================================
# We compare AR models using Akaike's Information Criterion 
# (AIC). The purpose is to identify the model with the 
# lowest AIC

AIC_values <- sapply(models, AIC)
print("AIC values for each AR model:")
print(AIC_values)

# Best model according to AIC:
best_model <- names(which.min(AIC_values))
cat("\nBest model according to AIC is:", best_model, "\n")

# Out of the five AR models tested, AR(5) not only had the 
# lowest AIC (828.04), but also showed a 13-point 
# improvement over AR(4), which is statistically meaningful, 
# according to Burnham and Anderson (2002), a drop of more 
# than 10 points is considered “strong evidence” in favor of 
# the lower model.

# ============================================
## Question 3:
# ============================================
# Perform Ljung-Box and Jarque-Bera tests on model residuals
# Interpret and compare results with AIC conclusions
for (name in names(models)) {
  cat("\nModel:", name, "\n")
  residuals <- resid(models[[name]])
  lb_test <- Box.test(residuals, lag = 10, type = "Ljung-Box")
  jb_test <- jarque.bera.test(residuals)
  print(lb_test)
  print(jb_test)
}
print(round(AIC_values, 2))

# We tested the AR models using the Ljung-Box test 
# (for autocorrelation) and the Jarque-Bera test 
# (for normality of residuals).
# We chose lag = 10 because our dataset has n=58,and 
# √n ≈ 7.6.
# A lag length of 10 covers 2.5 years of quarterly data, 
# This aligns with common practice in macroeconomic time 
# series, and helps us detect medium-term autocorrelation 
# without overfitting.
# AR(4) and AR(5) passed both tests.

# ============================================
# Summary:
# ============================================
cat("\nSummary:\n")
cat("The AR(5) model had the lowest AIC and passed both residual tests,\n")
cat("indicating no autocorrelation and approximate normality.\n")
cat("This model offers the best overall balance of fit and residual quality,\n")
cat("making it suitable for interpretation and forecasting purposes.\n")
