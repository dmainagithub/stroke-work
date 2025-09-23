. import delimited "D:\APHRC\GoogleDrive_ii\stata_do_files\madiva\stroke_work\cleaned_df
> .csv", bindquote(strict) varnames(1) stripquote(yes) clear 

bysort individual_id (obs_date): keep if _n == _N

// tab stroke_status_derived

do "value_labels.do"

save "D:\APHRC\GoogleDrive_ii\stata_do_files\madiva\stata_files\stroke_endline_data.dta", replace
