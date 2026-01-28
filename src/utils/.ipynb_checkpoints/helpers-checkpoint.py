import yaml
from pathlib import Path

def load_paths(config_filename="config.yaml"):
    """
    Load project paths from config.yaml regardless of where the notebook is run.
    """

    # Search upwards for config.yaml
    current_dir = Path.cwd()

    for parent in [current_dir] + list(current_dir.parents):
        config_path = parent / config_filename
        if config_path.exists():
            break
    else:
        raise FileNotFoundError(
            f"{config_filename} not found in current directory or any parent directories."
        )

    # Load YAML
    with open(config_path, "r") as f:
        config = yaml.safe_load(f)

    base_dir = Path(config["paths"]["base_dir"])

    # --------------------------------------------------
    # Build paths dictionary
    # --------------------------------------------------
    paths = {
        "BASE_DIR": base_dir,
        "DATA_DIR": Path(config["paths"]["data_dir"].format(base_dir=base_dir)),
        "OUT_DIR":  Path(config["paths"]["out_dir"].format(base_dir=base_dir)),
        "FIG_DIR":  Path(config["paths"]["fig_dir"].format(base_dir=base_dir)),
        "MODEL_DIR":  Path(config["paths"]["statsmodels"].format(base_dir=base_dir)),
        "NOTEBOOKS_DIR": Path(config["paths"]["notebooks_dir"].format(base_dir=base_dir)),
        "NOTEBOOKS_EXECUTED_DIR": Path(
            config["paths"]["notebooks_executed_dir"].format(base_dir=base_dir)
        ),
    }

    # --------------------------------------------------
    # Ensure directories exist
    # --------------------------------------------------
    for key, p in paths.items():
        if isinstance(p, Path):
            p.mkdir(parents=True, exist_ok=True)

            
    # # --------------------------------------------------
    # # Ensure output directories exist
    # # --------------------------------------------------
    # #paths["OUT_DIR"].mkdir(parents=True, exist_ok=True)
    # #paths["FIG_DIR"].mkdir(parents=True, exist_ok=True)
    # # Ensure directories exist
    # for p in paths.values():
    #     if isinstance(p, Path):
    #         p.mkdir(parents=True, exist_ok=True)
    # # --------------------------------------------------

    return paths
