cd "D:\APHRC\GoogleDrive_ii\stata_do_files\madiva\stata_files"

// load data
use "stroke_data.dta", clear

bysort individual_id (obs_date): keep if _n == 1

save "stroke_baseline_data.dta", replace




