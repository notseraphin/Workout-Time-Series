# Workout-Time-Series

***Strength Progression & Training Volume Analysis***

***Overview***

This project analyzes workout training data over time to quantify weekly training volume and strength progression across muscle groups.

The objective is to transform raw workout logs into interpretable metrics that describe:

- Weekly training volume by muscle group
- Estimated 1RM (one-rep max) progression
- Aggregate strength improvements by muscle group

The pipeline combines SQL-based aggregation with Python visualization to produce reproducible analytical outputs.

***Data Source***

- Personal workout logs stored in relational tables

- Exercise-level records including:
  - Muscle group
  - Sets
  - Repetitions

Derived datasets:
  - weekly_volume.csv — weekly training volume by muscle group
  - results.txt — SQL query output containing progression metrics

***Model / Analysis Description***
***Weekly Volume Aggregation***

- Training data is grouped by:
  - Year
  - Week
  - Muscle group
- Metrics computed:
  - Total sets
  - Total repetitions
***Strength Progression***
- Estimated 1RM values are tracked per exercise
- Week-to-week changes in 1RM are computed
- Progression is aggregated at the muscle group level

***Summary Metrics***

For each muscle group:
- Number of tracked exercises
- Average Δ1RM
- Total Δ1RM

***Visualization Outputs***

The analysis produces the following figures:
- Weekly training volume heatmap (muscle group × week)
- Weekly repetition trend over time
- Exercise-level 1RM progression
- Average Δ1RM per muscle group
All figures are automatically saved to the figures/ directory.
```bash
Project Structure
Workout-Time-Series/
│── sql/
│   ├── 1_create_tables.sql
│   ├── 2_import_csv.sql
│   ├── 3_populate_tables.sql
│   ├── 4_weekly_volume.sql
│   ├── 5_compute_1rm_changes.sql
│   ├── 6_progression_by_muscle.sql
│   ├── 7_results.sql
│   └── run_all.sql
│
│── results/
│   ├── weekly_volume.csv
│   └── results.txt
│
│── figures/
│   ├── weekly_volume_heatmap.png
│   ├── weekly_reps_trend.png
│   ├── exercise_1rm_progression.png
│   └── avg_delta_1rm_per_muscle.png
│
│── src/
│   └── visualization.py
│
│── README.md
│── requirements.txt
```
***Results Interpretation***

- Muscle groups with higher average Δ1RM exhibit stronger strength gains over time
- Volume heatmaps reveal imbalances and specialization phases in training
- Exercise-level progression highlights consistency and plateaus in performance
These outputs enable both longitudinal tracking and comparative muscle group analysis.

***Technologies Used**
- ostgreSQL
- SQL
- Python
  - pandas
  - matplotlib
  - seaborn
