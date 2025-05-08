clear all

set seed 1234 

set obs 1000

forval c=1/5{
g r_`c'=rnormal()
}

sum

g n=_n

g x=r_1

replace x=r_1*5 if n>500

g e=r_2

g y=1*x+e
replace y=5*x+e if n>500

reg y x if n>500
reg y x if n<500
reg y x

*************

g w=r_3
g x2=r_4
replace w=x2 + 0.5*w if n>500

g y2=1*x2+e
replace y2=5*x2+e if n>500

reg y2 x2 if n>500
reg y2 x2 w if n>500

reg y2 x2 if n<500
reg y2 x2 w if n<500

reg y2 x2
reg y2 x2 w

