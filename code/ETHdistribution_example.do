// Do file to grow the ETH 2015.5 survey to 2018 using GPDpc growth
global output "C:\Users\wb562356\OneDrive - WBG\Documents\PovcalNet_Data_Stuff\ETHdist_example\"
************************
// load 2011 cpi and ppp
************************
pcn master, load(CPI)
keep if countrycode=="ETH"
keep if year==2015
local cpi2011 = cpi

pcn master, load(PPP)
keep if countrycode=="ETH"
local ppp2011 = ppp2011

*************************
// load GDPpc growth rate
*************************
pcn master, load(gdp)
keep if countrycode=="ETH"
keep if inlist(year,2015,2016,2018)
reshape wide gdp, i(countrycode coveragetype) j(year)
gen gdp20155 = (gdp2015+gdp2016)/2
gen g20155_2018 = gdp2018/gdp20155 - 1
local g20155_2018 = g20155_2018

*************************************************************
// project the 2015.5 distribution to 2018 using GPDpc growth
*************************************************************
use "P:\01.PovcalNet\01.Vintage_control\ETH\ETH_2015_HICES\ETH_2015_HICES_V01_M_V02_A_GMD\Data\ETH_2015_HICES_v01_M_v02_A_GMD_PCN.dta", clear
gen cpi2011 = 		`cpi2011'
gen ppp2011 = 		`ppp2011'
gen g20155_2018 = 	`g20155_2018'

// daily consumption adjusted for PPP
gen welf2011ppp_20155 = welfare/cpi2011/ppp2011 * 12/365
gen welf2011ppp_2018 = welf2011ppp_20155 * (1 + g20155_2018)

save "${output}ETHdist_example.dta", replace

exit