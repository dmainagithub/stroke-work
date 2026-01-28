# -----------------------------------------------------------------------------
# Shared covariates definitions for stroke analysis
# -----------------------------------------------------------------------------
# Ensure all columns used in the model are numeric
# X = df.drop(['stroke_status_derived', 'individual_id', 'obs_date'], axis=1, errors='ignore')
COVARIATES = [
    'sex_binary',
    'alcohol_use',
    'tobacco_use',
    'hpt_status_derived',
    'diab_status_derived',
    'bmi_category_Overweight_Obese',
    'hiv_status_derived',
    'site_Nairobi'
]

# -----------------------------------------------------------------------------
# Predictors - forest plots/compare across sites
# -----------------------------------------------------------------------------
# predictors to display in forest plots/compare across sites
KEY_PREDICTORS = [
    'hpt_status_derived',
    'diab_status_derived',
    'tb_status_derived'
] # , 'site_Nairobi'
# 'sex_binary', 'alcohol_use', 'tobacco_use', 'hpt_status_derived','obese_status_derived', 'diab_status_derived','bmi_refined','hiv_status_derived', 'tb_status_derived'

# -----------------------------------------------------------------------------
# Optional: grouped covariates
# -----------------------------------------------------------------------------
DEMOGRAPHIC_VARS = [
    'sex_binary',
    'site_Nairobi'
]

# -----------------------------------------------------------------------------
# Optional: clinical variables
# -----------------------------------------------------------------------------
CLINICAL_VARS = [
    'hpt_status_derived',
    'diab_status_derived',
    'hiv_status_derived',
    'bmi_category_Overweight_Obese'
]

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------

