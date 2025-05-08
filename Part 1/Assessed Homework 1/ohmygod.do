*********************************************************
*********************************************************
* 		INCLUSION OF CONTROLS			*
*********************************************************
*********************************************************

clear all

set seed 1000

set obs 1000

//generate some random variables
forval v=1/5 {
gen v`v'=rnormal()
}

g N=_n

ren v1 X1   //this will be our variable of interest

//now set the true beta coefficients and generate outcome

local b1=1
local b2=5

g Y1=`b1'*X1 + v4 
replace Y1=`b2'*X1 + v4  if N>500

//generate control that correlates with X1
g W=v3		
replace W= X1+0.5*v3 if N>500

//now run regressions

reg Y1 X1 if N<500, robust

reg Y1 X1 W if N<500, robust

reg Y1 X1 if N>500, robust

reg Y1 X1 W if N>500, robust

reg Y1 X1, robust

reg Y1 X1 W, robust
