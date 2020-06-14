generate arrest = 0 
replace arrest= 1 if bac1>=0.08

hist bac1, xline(0.08) width(0.001)

cd "C:\Users\malej\Downloads"
*McCrary density test
net install rddensity, from(https://sites.google.com/site/rdpackages/rddensity/stata) replace
net install lpdensity, from(https://sites.google.com/site/nppackages/lpdensity/stata) replace

rddensity bac1, c(0.08) plot
lpdensity bac1, c(0.08) plot

ssc install estout, replace
quietly regress bac1 male if bac1<0.08
eststo model1
quietly regress bac1 white if bac1<0.08
eststo model2
quietly regress bac1 aged if bac1<0.08
eststo model3
quietly regress bac1 acc if bac1<0.08
eststo model4

esttab using table2.doc, replace


ssc install cmogram, replace
cmogram male bac1, cut(0.08) scatter line(0.08) qfitci lfit title(Panel_A)
graph save panela.gph, replace 
cmogram white bac1, cut(0.08) scatter line(0.08) qfitci lfit title(Panel_B)
graph save panelb.gph, replace
cmogram aged bac1, cut(0.08) scatter line(0.08) qfitci lfit title(Panel_C)
graph save panelc.gph, replace 
cmogram acc bac1, cut(0.08) scatter line(0.08) qfitci lfit title(Panel_D)
graph save paneld.gph, replace 
graph combine panela.gph panelb.gph panelc.gph paneld.gph

ssc install rdrobust
rdrobust recidivism bac1 male, c(0.08)
eststo mod1
rdrobust recidivism bac1 white, c(0.08)
eststo mod2
rdrobust recidivism bac1 aged, c(0.08)
eststo mod3
rdrobust recidivism bac1 acc, c(0.08)
eststo mod4
esttab using table3.doc, replace
