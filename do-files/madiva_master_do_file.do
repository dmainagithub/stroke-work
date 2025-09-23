clear all
// Import data
import delimited "D:\APHRC\GoogleDrive_ii\stata_do_files\madiva\data\extractions\p2_stroke_20250624.csv", bindquote(strict) varnames(1) stripquote(yes)
 
sort individual_id obs_date
bysort individual_id: gen n_records = _N
// tab n_records

do "value_labels.do"

// Save data
save "D:\APHRC\GoogleDrive_ii\stata_do_files\madiva\stata_files\stroke_data.dta", replace




