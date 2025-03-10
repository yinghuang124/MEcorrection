setwd("C:/Users/yhuang/OneDrive - Fred Hutchinson Cancer Research Center/Documents/All_Files/1yingsstuff/ME/Github")


load(file="example.Rdata")


source(file="Fun.R")

### Cox model fitting with quadratic exposure effect

out.Quadra<-jointCal.Quadra(W1.v=data.biomarker$W1,W2.v=data.biomarker$W2,Q.v=data.biomarker$Q,V.v=data.biomarker$V,
Q=data.Quadra$Q,V=data.Quadra$V,Y=data.Quadra$Y,delta=data.Quadra$delta)


q.1<-qnorm(1/3,mean=0,sd=1)
q.2<-qnorm(2/3,mean=0,sd=1)


### Cox model fitting with tertile exposure effect, with tertile values pre-specified

out.Tert1<-jointCal.Quant(W1.v=data.biomarker$W1,W2.v=data.biomarker$W2,Q.v=data.biomarker$Q,V.v=data.biomarker$V,
Q=data.Quant$Q,V=data.Quant$V,Y=data.Quant$Y,delta=data.Quant$delta,q.inner=c(q.1,q.2),arg=0)


### Cox model fitting with tertile exposure effect, with unknown tertile values

out.Tert2<-jointCal.Quant(W1.v=data.biomarker$W1,W2.v=data.biomarker$W2,Q.v=data.biomarker$Q,V.v=data.biomarker$V,
Q=data.Quant$Q,V=data.Quant$V,Y=data.Quant$Y,delta=data.Quant$delta,q=3,arg=1)




### Cox model fitting with quartile exposure effect, with unknown tertile values

out.Quart2<-jointCal.Quant(W1.v=data.biomarker$W1,W2.v=data.biomarker$W2,Q.v=data.biomarker$Q,V.v=data.biomarker$V,
Q=data.Quant$Q,V=data.Quant$V,Y=data.Quant$Y,delta=data.Quant$delta,q=4,arg=1)
