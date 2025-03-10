
### Function to fit Quadratic exposure effect Cox model to nutritional epidemiology cohort,
### utilizing biomarker sample for calibration
### Input
## W1.v and W2.v: replicate biomarker value in biomarker subsample
## Q.v: self-report in biomarker subsample
## V.v: covariate in biomarker subsample
## Q: self-report dietary intake in nutritional epidemiology cohort
## Y: follow up time in nutritional epidemiology cohort
## delta: indicator for event (delta=1) or censoring (delta=0)

### Output
### RCN: RCN estimates of coefficients in Cox model of ~Z+Z^2+V 
### RCP: RCP estimates of coefficients in Cox model of ~Z+Z^2+V 


jointCal.Quadra<-function(W1.v,W2.v,Q.v,V.v,Q,V,Y,delta){
    fit0=lm(W1.v~Q.v+V.v)
    mu=fit0$coef[1]+fit0$coef[2]*Q+fit0$coef[3]*V
    
    sigma2.e.est=var(W1.v-W2.v,use="complete.obs")/2  ### estimate of ME in W
    sigma2.est<-summary(fit0)$sigma^2-sigma2.e.est    ### estimate of var(Z|Q,V), based on estimated ME in W
    
    
    ### RCN
    fit=coxph(Surv(Y,delta)~mu+I(mu^2)+V)
    
    coef.RC1=fit$coef
   
    beta1.tilde=fit$coefficients[1]
    beta2.tilde=fit$coefficients[2]
   
    ### RCP
    beta2.e=beta2.tilde/(1+2*beta2.tilde*sigma2.est)
    beta1.e=beta1.tilde*(1-2*beta2.e*sigma2.est)
     
    out.beta<-list(RCN=coef.RC1,RCP=c(beta1.e,beta2.e,coef.RC1[3]),
    VarZ.QV<-sigma2.est)
    return(out.beta)
}

### Function to fit Cox model with dietary exposure quantiles to nutritional epidemiology cohort,
### utilizing biomarker sample for calibration
### Input
## W1.v and W2.v: replicate biomarker value in biomarker subsample
## Q.v: self-report in biomarker subsample
## V.v: covariate in biomarker subsample
## Q: self-report dietary intake in nutritional epidemiology cohort
## V: covariate in nutritional epidemiology cohort
## Y: follow up time in nutritional epidemiology cohort
## delta: indicator for event (delta=1) or censoring (delta=0)
## q: degree of the quantile, have to be specified for arg=1
## qcut: input values for dietary exposure categories, have to be specified for arg=0
## arg: indicator of whether estimating hazard within pre-defined dietary exposure cateogry (arg=0) or estimated quantiles (arg=1) 

## 
### Output
### coef.RCN: RCN estimates of coefficients in Cox model of ~(1 to (q-1)^th q-quantiles of Z)+V 
### coef.RCP: RCP estimates of coefficients in Cox model of ~(1 to (q-1)^th q-quantiles of Z)+V 
### q.inner.RCN: quantile values of Z used for RCN
### q.inner.RCP: quantile values of Z used for RCP

jointCal.Quant<-function(W1.v,W2.v,Q.v,V.v,Q,V,Y,delta,q.inner,q,arg=0){
   
    ## estimate calibration equation of E(Z|Q,V)
    fit0=lm(W1.v~Q.v+V.v)
    
    ### estimate mean of true dietary intake in the cohort
    mu=fit0$coef[1]+fit0$coef[2]*Q+fit0$coef[3]*V
    
    ## estimate Var(Z|Q,V)
    sigma2.e.est=var(W1.v-W2.v,use="complete.obs")/2  ### estimate of ME in W
    sigma2.est<-summary(fit0)$sigma^2-sigma2.e.est    ### estimate of var(Z|Q,V), based on estimated ME in W
    
    
    sigma2.z.est<-var(W1.v)-sigma2.e.est      ### estimate of 
    
    ### estimate cutoff values for q-quantiles, assuming Z follows a normal distribution
    if (arg==1){
        
        qq<-1:(q-1)
        q.inner<-mean(mu)+qnorm(qq/q)*sqrt(sigma2.z.est)
        
    }
   
     
    ## generate categorical exposure for RCN
    
    ## the category values have to be within the range of mu for RCN
    q.in<-q.inner[q.inner>min(mu) & q.inner<max(mu)]
    qq<-c(sort(q.in),Inf)
    
   
    for (k in 1:(length(q.in))){
     assign(paste("mu.q",k,sep=''),mu>qq[k] & mu<=qq[k+1], envir = .GlobalEnv)
    }
      
    predictors.RCN <- paste0("mu.q", 1:length(q.in), collapse = " + ")  
    formula.RCN <- as.formula(paste("Surv(Y,delta)~", predictors.RCN,'+V',sep=''))  
    
    ## generate categorical exposure for RCP
    mu.q1.cal=pnorm(q.2,mean=mu,sd=sqrt(sigma2.est))-pnorm(q.1,mean=mu,sd=sqrt(sigma2.est))
    mu.q2.cal=1-pnorm(q.2,mean=mu,sd=sqrt(sigma2.est))
   
    qq<-c(sort(q.inner),Inf)
    
    for (k in 1:length(q.inner)){
      assign(paste('mu.cal.q',k,sep=''),pnorm(qq[k+1],mean=mu,sd=sqrt(sigma2.est))-pnorm(qq[k],mean=mu,sd=sqrt(sigma2.est)),envir=.GlobalEnv)
    }

    predictors.RCP <- paste0("mu.cal.q", 1:length(q.inner), collapse = " + ")  
    formula.RCP <- as.formula(paste("Surv(Y,delta)~", predictors.RCP,'+V',sep=''))  
    

    fit.RCN=coxph(formula.RCN,data=data.frame(Y=Y,delta=delta,mu.q1=mu.q1,mu.q2=mu.q2,V=V))
    fit.RCP<-coxph(formula.RCP, data=data.frame(Y=Y,delta=delta,mu.cal.q1=mu.cal.q1,mu.cal.q2=mu.cal.q2,V=V))
    
    
    out.beta<-list(coef.RCN=coef(fit.RCN),coef.RCP=coef(fit.RCP),q.inner.RCN=q.in,q.inner.RCP=q.inner)
    return(out.beta)
}
