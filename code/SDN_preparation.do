global output "C:\WBG\Methodology\code"

*********************
*** STORE CPI/PPP ***
*********************
pip, country(SDN) year(2014) clear
scalar cpi = cpi
scalar ppp = ppp

****************
*** LOAD GDP ***
****************
pip tables, table(gdp) clear
keep if country_code=="SDN" & inrange(year,2014,2019)
forvalues yr=2014/2019 {
sum if year==`yr'
scalar gdp`yr' = `r(mean)'
}

**********************
*** LOAD MICRODATA ***
**********************
dlw, coun(SDN) y(2014) t(GMD) mod(GPWG) verm(01) vera(02) sur(NBHS) nocpi
keep welfare weight
gen welfare2014 = welfare/cpi/ppp/365
gen welfare2019 = welfare2014*(1+(gdp2015/gdp2014-1)*0.7)*(1+(gdp2016/gdp2015-1)*0.7)*(1+(gdp2017/gdp2016-1)*0.7)*(1+(gdp2018/gdp2017-1)*0.7)*(1+(gdp2019/gdp2018-1)*0.7)
keep welfare2014 welfare2019 weight
drop if missing(weight)
compress
save "SDN_example.dta", replace
