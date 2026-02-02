"""
Run the full Stroke Analysis notebook pipeline in order.

Usage:
    python run_pipeline.py
"""

import papermill as pm
from datetime import datetime
import sys
from pathlib import Path

# ---------------------------------------------------------------------
# Make src importable
# ---------------------------------------------------------------------
PROJECT_ROOT = Path(__file__).resolve().parent
if str(PROJECT_ROOT) not in sys.path:
    sys.path.insert(0, str(PROJECT_ROOT))

from src.utils.helpers import load_paths

# ---------------------------------------------------------------------
# Load paths from config.yaml
# ---------------------------------------------------------------------
paths = load_paths()

NOTEBOOK_DIR = paths["NOTEBOOKS_DIR"]
OUTPUT_DIR = paths["NOTEBOOKS_EXECUTED_DIR"]

# ---------------------------------------------------------------------
# Notebook execution order
# ---------------------------------------------------------------------
NOTEBOOKS = [
    "01_setup_and_imports.ipynb",
    "02_data_cleaning_and_harmonization.ipynb",
    "03_preprocessing_and_covariates.ipynb",
    "04_person_time_and_events.ipynb",
    "05_exploratory_and_diagnostics.ipynb",
    "06_models_logistic.ipynb",
    "07_models_poisson_nb.ipynb",
    "07_diagnostics_ii.ipynb",
    "07_sensitivity_analysis_iii.ipynb",
    # "07_shap_explainability_iv.ipynb",
    "08_visualization_and_reporting.ipynb",
    "10_roc_and_calibration.ipynb",
]

# ---------------------------------------------------------------------
# Execute notebooks
# ---------------------------------------------------------------------
print("Starting Stroke Analysis Pipeline...")
start_time = datetime.now()

for nb in NOTEBOOKS:
    input_nb = NOTEBOOK_DIR / nb
    output_nb = OUTPUT_DIR / nb

    print(f"\nRunning: {nb}")
    pm.execute_notebook(
        input_path=input_nb,
        output_path=output_nb,
        kernel_name="python3",
    )

end_time = datetime.now()

print("\nPipeline completed successfully!")
print(f"Start time: {start_time}")
print(f"End time  : {end_time}")
print(f"Duration  : {end_time - start_time}")
print(f"Executed notebooks saved to: {OUTPUT_DIR}")
