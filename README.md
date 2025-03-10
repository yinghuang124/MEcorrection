MEcorrection

Using biomarker subsample to correcting for measuremet error in self-reported dietary intake when estimating quadratic and quantile exposure effects on disease hazard in Cox model  

This folder contains the following files:

1. Example.R  --- R code to read in the simulated data and estimate quandratic and quantile models after adjusing for measurement error
it also includes the output of the R code implementation 

2. Fun.R  --- contains major functions for fitting Cox models with quadratic effect and quantile effect of error-prone exposure

3. example.Rdata --- simulated R data of nutritional epidmiology cohort study (one for fitting the quadratic model and the other for fitting the quantile effect model) and the biomarker subsample, it consists of the following three data object

#####
(1) data.Quadra: nutritional epidemiology cohort study data for fitting Cox model with quadratic covariate effect, it includes the following variables:

## Q: self-reported dietary intake 
## V: covariate 
## Y: follow up time 
## delta: indicator for event (delta=1) or censoring (delta=0)

######
(2) data.Quant: nutritional epidemiology cohort study data for fitting Cox model with Tertile covariate effect, it includes the following variables:
## Q: self-reported dietary intake 
## V: covariate 
## Y: follow up time 
## delta: indicator for event (delta=1) or censoring (delta=0)

(3) data.biomarker: data for the biomarker subsample, it includes the following variables

## W1 and W2: replicate biomarker value
## Q: self-reported dietary intake
## V: covariate
