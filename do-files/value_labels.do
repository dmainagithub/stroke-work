// Value labels
* 2. Recode invalid codes to missing
foreach var in stroke_status_derived hiv_status_derived hpt_status_derived obese_status_derived diab_status_derived tb_status_derived sex {
    replace `var' = . if inlist(`var', 333, 444, 888, 999)
}

foreach var in age bmi bp_dia bp_sys {
    replace `var' = . if inlist(`var', -9, -333, -444, -888, -999)
}

label define yesno 1 "Yes" 0 "No"
label define sex 1 "Male" 2 "Female"

label value hiv_status_derived yesno
label value stroke_status_derived yesno 
label value hpt_status_derived yesno 
label value obese_status_derived yesno 
label value diab_status_derived yesno 
label value tb_status_derived yesno
label value sex sex
