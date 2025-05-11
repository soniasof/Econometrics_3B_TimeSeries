# Econometrics_3B_TimeSeries
Course portfolio: Time Series modeling, forecasting, and analysis in R (Spring 2025)
---

# Assignment 1: Time Series Modeling (IEC7413)
This project is part of the Econometrics 3B course (IEC7413) and focuses on modeling and analyzing UK household income data using time series methods.

## Project Goal
To evaluate quarterly household income data in the UK (1971–1985) using autoregressive models, select the best model using AIC, and check whether the model fits well using residual tests.

## Dataset
* **Source**: `IncomeUK` dataset from the `Ecdat` R package
* **Variable used**: `income` — quarterly disposable household income in nominal pounds

## Methods
* **First-differencing** was used to make the income series more stable (stationary)
* **AR(p) models** from AR(1) to AR(5) were estimated using `dynlm()`
* **Model comparison** was done using Akaike’s Information Criterion (**AIC**)
* **Residual diagnostics**:
  * **Ljung–Box test** for autocorrelation
  * **Jarque–Bera test** for normality

## Results
* **AR(5)** had the lowest AIC (828.04), showing a 13-point improvement over AR(4)
* According to Burnham & Anderson (2002), a difference >10 in AIC is strong evidence in favor of the better model
* **AR(5)** also passed both residual tests, making it the best overall model

## How to Run
1. Open the `assignment1_problem1.Rmd` file in RStudio
2. Install the required packages if needed:

   ```r
   install.packages(c("Ecdat", "dynlm", "lmtest", "tseries"))
   ```
   
3. Click **Knit** to generate the HTML report

## Notes
* The project focuses on model selection and diagnostics, not forecasting
* All interpretations are written in simple, clear language with minimal technical jargon

---

Author: Sonia Sofia
Course: Econometrics 3B – Spring 2025
