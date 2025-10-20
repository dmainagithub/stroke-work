# Author:   Daniel Maina Nderitu
# Year:     2025-Oct
# Project:  Stroke Analysis
# Import data
df_processed <- read.csv("D:/APHRC/GoogleDrive_ii/stata_do_files/madiva/stroke_work/data/df_processed.csv")
# View data
View(df_processed)


glm(df_processed$stroke_status_derived ~ df_processed$hpt_status_derived, data=df_processed, family = "poisson")

