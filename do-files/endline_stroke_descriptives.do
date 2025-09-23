// summarize  

 // Export wonderful tables 

// Continuous variables 
asdoc bysort stroke_status_derived: summarize age bmi, detail save(stroke_endline_tables.doc) replace

// Cross-tab
asdoc tab sex stroke_status_derived , row col  append
asdoc tab hiv_status_derived stroke_status_derived, row col append
asdoc tab hpt_status_derived stroke_status_derived, row col append
asdoc tab obese_status_derived stroke_status_derived, row col append
asdoc tab diab_status_derived stroke_status_derived, row col append
asdoc tab tb_status_derived stroke_status_derived, row col append

// Format ii
asdoc tab1 sex hpt_status_derived diab_status_derived obese_status_derived tb_status_derived hiv_status_derived, save(stroke_endline_tables_collapsed.doc) replace

// Tabout command (much better)
tabout sex  hpt_status_derived diab_status_derived obese_status_derived tb_status_derived hiv_status_derived stroke_status_derived using stroke_endline_tables_iii.xls, c(freq col) f(0c) replace

    



