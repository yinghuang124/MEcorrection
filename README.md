MEcorrection

Using biomarker subsample to correcting for measuremet error in self-reported dietary intake when estimating quadratic and quantile exposure effects on disease hazard in Cox model  

This folder contains the following files:

1. Example.R  --- R code to read in the simulated data and estimate quandratic and quantile models after adjusing for measurement error
it also includes the output of the R code implementation 

2. FunQuadratic.R  --- contains major functions for fitting Cox models with quadratic effect of error-prone exposure

3. FunQuantile.R --- contains major functions for fitting Cox models with quantile effect of error-prone exposure

4. example.Rdata --- simulated R data of nutritional epidmiology cohort study (one for fitting the quadratic model and the other for fitting the quantile effect model) and the biomarker subsample, it consists of the following three 
data object

#####
(1) data.Quadra: nutritional epidemiology cohort study data for fitting Cox model with quadratic covariate effect, it includes the following variables:

### ID: participant id
### ZE: treatment indicator: 0, 1 for placebo and vaccine
### WE: covariate to adjust for in the linear mixed effects model (LME) of immune response trajectory
### WEc: confounder to adjust for in the Cox model
### RE: peak time point after vaccination, measured on calendar scale
### SE: minimum of infection and censoring time, measured on calendar scale
### TE: SE-RE, time post peak to SE
### XE0: peak immune response
### delta: case/control indicator, 1, 0 for case and control respectively
### incoh: binary indicator that a vaccine recipient is included in the immune correlates study
### weight: inverse of probability of sampling into the immune correlates study for vaccine recipients, 1 for placeob 

######
(2) data.Tert: nutritional epidemiology cohort study data for fitting Cox model with Tertile covariate effect, it includes the following variables:

(2) datlong: the immune correlates study data among vaccine recipients in long format, it includes the following variables

### id: participant id, should be a subset of ID in "data"
### visit: visit number for measuring immune responses
### R: peak time point after vaccination, measured on calendar scale
### time: time post peak to immune response measuremnent
### X: immune response measure
### W: covariate to adjust for in the linear mixed effect model
### S: minimum of infection and censoring time, measured on calendar scale
### Z: treatment indicator: 0, 1 for placebo and vaccine
### weights: inverse of probability of sampling into the immune correlates study for vaccine recipients, 0 for placebo 
(i.e. LME is only fitted using vaccinee data)
