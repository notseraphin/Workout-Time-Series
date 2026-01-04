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
  - weekly_volume.csv : weekly training volume by muscle group
  - results.txt : SQL query output containing progression metrics

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

***Analysis***

Muscle groups showed heterogeneous responses to training volume and exercise selection:
- Calves exhibited the highest average Δ1RM per exercise, despite relatively low weekly volume. This suggests high responsiveness and indicates that the current loading and frequency are sufficient for continued progress.
- Hamstrings demonstrated strong and consistent progression, aligning with relatively high weekly volume. The combination of compound hip-hinge movements and sufficient workload appears effective and should be maintained.
- Shoulders, Lats, Chest, and Quads showed moderate positive progression under high training volumes. While volume is adequate, the marginal strength gains suggest these groups may benefit from slightly increased intensity (heavier sets) rather than further volume increases.
- Biceps showed minimal progression despite moderate volume, indicating that current loading may be insufficient. Introducing heavier loads, lower rep ranges, or improved exercise selection could improve stimulus.
- Triceps displayed negative average progression, despite high weekly volume. This suggests accumulated fatigue or poor stimulus-to-fatigue ratio, likely due to excessive isolation work (e.g., extensions). Reducing volume and prioritizing compound pressing movements may improve outcomes.
- Adductors showed low progression, which is likely constrained by equipment limitations. Since the adductor machine does not provide sufficient resistance, compound lower-body lifts may be more effective for adductor development.

**Volume vs. Progression Insights**

- Comparing weekly volume with strength progression highlights an important pattern:
- Higher volume does not guarantee higher progression.
- Muscle groups with moderate volume and adequate loading often outperformed those with very high volume but insufficient intensity.
- Excessive volume without progressive overload appears to contribute to stagnation or regression in some muscle groups.

**Overall Conclusion**

The results suggest that the training program would benefit from redistributing effort toward higher-quality, heavier sets, particularly for muscle groups already receiving high weekly volume. Strength progression appears most strongly associated with progressive overload and exercise selection, rather than sheer volume.

***Technologies Used***
- PostgreSQL
- SQL
- Python
  - pandas
  - matplotlib
  - seaborn
