clear all

*type "search esttab" and install the first package that comes up. 


*********************************************************
*********************************************************
* 		TABLE 1											*
*********************************************************
*********************************************************

*multivariate ols and heterogeneity

clear all

set seed 1000

set obs 1000

//generate some random variables
forval v=1/5 {
gen v`v'=rnormal()
}

g N=_n
g T=_N

*generate indictor for strata/group
g strata=1
replace strata=2  if N/T>0.5

ren v1 X   //this will be our variable of interest

//now set the true beta coefficients and generate outcome

local b1=1
local b2=5

g Y=`b1'*X + v4 
replace Y=`b2'*X + v4  if strata==2  

g W=v3		//this is the variable that has a correlation with X for some individuals but not for others
replace W=  X+0.5*v3 if strata==2  

//now run regressions

//subgroup estimates unchanged (adding irrelevant variable with homogeneous effects within these groups)
reg Y X if strata==1  , robust
est sto c1

reg Y X W if strata==1  , robust
est sto c2

reg Y X  if strata==2  , robust
est sto c3

reg Y X W if strata==2  , robust
est sto c4

//Estimate ATE (should be 3) in simple OLS
reg Y X, robust
est sto c5

//now include irrelevant control W
reg Y X W, robust
est sto c6

esttab c*,  mtitles("Sample 1" "Sample 1" "Sample 2" "Sample 2" "Pooled" "Pooled") se  tex
	
esttab c*,  mtitles("Sample 1" "Sample 1" "Sample 2" "Sample 2" "Pooled" "Pooled") se  
