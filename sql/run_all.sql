\echo ==== Running 1_create_tables.sql ====
\i 'C:/Users/serap/WorkoutTimeSeries/1_create_tables.sql'

\echo ==== Running 2_import_csv.sql ====
\i 'C:/Users/serap/WorkoutTimeSeries/2_import_csv.sql'

\echo ==== Running 3_populate_tables.sql ====
\i 'C:/Users/serap/WorkoutTimeSeries/3_populate_tables.sql'

\echo ==== Running 4_weekly_volume ====
\i 'C:/Users/serap/WorkoutTimeSeries/4_weekly_volume.sql'

\echo ==== Running 5_compute_1rm_changes.sql ====
\i 'C:/Users/serap/WorkoutTimeSeries/5_compute_1rm_changes.sql'

\echo ==== Running 6_progression_by_muscle.sql ====
\i 'C:/Users/serap/WorkoutTimeSeries/6_progression_by_muscle.sql'

\echo ==== Final Results ====
\i 'C:/Users/serap/WorkoutTimeSeries/7_results.sql'


\echo ==== DONE ====
