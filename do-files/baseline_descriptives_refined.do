****************************************************
* Descriptive Analysis: Table 1 for Stroke Project
****************************************************

clear all
set more off

* ===============================
* Load your dataset
* ===============================
use "stroke_baseline_data.dta", clear

* ===============================
* Recode categorical missing codes
* ===============================
local catvars sex hiv_status_derived hpt_status_derived obese_status_derived diab_status_derived tb_status_derived

foreach var of local catvars {
    capture confirm variable `var'
    if !_rc {
        replace `var' = . if inlist(`var', 333, 444, 888, 999)
    }
    else {
        di as error "NOTE: variable `var' not found — skipping"
    }
}

* ===============================
* Create stroke_status_group
* ===============================
capture confirm variable stroke_status_derived
if _rc {
    di as err "ERROR: stroke_status_derived not found. Exiting."
    exit 1
}

gen stroke_status_group = .
replace stroke_status_group = 1 if stroke_status_derived == 0   // No Stroke
replace stroke_status_group = 2 if stroke_status_derived == 1   // Stroke
replace stroke_status_group = 3 if missing(stroke_status_derived)   // Missing

label define strokegrp 1 "No Stroke" 2 "Stroke" 3 "Missing"
label values stroke_status_group strokegrp

* ===============================
* Generate Table 1 (long format first)
* ===============================
tempfile results
save `results', emptyok replace

foreach var of local catvars {

    capture confirm variable `var'
    if _rc continue

    tempfile total bystroke

    * Overall distribution (Total column)
    preserve
        keep if !missing(`var')
        contract `var', freq(freq_total)
        gen stroke_status_group = 999   // placeholder for "Total"
        rename freq_total _freq
        gen variable = "`var'"
        rename `var' category
        save `total', replace
    restore

    * By stroke status
    preserve
        keep if !missing(`var') & !missing(stroke_status_group)
        contract stroke_status_group `var', freq(freq_by)
        rename freq_by _freq
        gen variable = "`var'"
        rename `var' category
        save `bystroke', replace
    restore

    * Combine overall + by stroke
    use `bystroke', clear
    append using `total'
    append using `results'
    save `results', replace
}

* ===============================
* Prepare table for presentation
* ===============================
use `results', clear

* Collapse again to remove duplicates before reshape
collapse (sum) _freq, by(variable category stroke_status_group)

* Compute denominators (N) per variable & stroke group
bysort variable stroke_status_group: egen N = total(_freq)

* Create n/N (%) string
gen cell = string(_freq) + "/" + string(N) + " (" + string(round(100*_freq/N,1)) + "%)"

* ===============================
* Reshape wide safely
* ===============================
reshape wide cell _freq N, i(variable category) j(stroke_status_group)

* ===============================
* Export
* ===============================
asdoc list variable category cell*, save(Table1.doc) replace
export excel using Table1.xlsx, firstrow(variables) replace
