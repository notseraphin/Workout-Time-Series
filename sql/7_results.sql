-- Combine muscle progression with weekly volume for context
\echo ==== Muscle Progression ====
SELECT * FROM muscle_progression;

\echo ==== Average Weekly Volume by Muscle ====
WITH weekly_volume AS (
    SELECT
        EXTRACT(YEAR FROM w.workout_date) AS year,
        EXTRACT(WEEK FROM w.workout_date) AS week,
        e.muscle_group,
        COUNT(ws.id) AS total_sets,
        SUM(ws.reps) AS total_reps
    FROM WorkoutSet ws
    JOIN Workout w ON ws.workout_id = w.id
    JOIN Exercise e ON ws.exercise_id = e.id
    GROUP BY year, week, e.muscle_group
)
SELECT muscle_group, 
       AVG(total_sets) AS avg_sets_per_week,
       AVG(total_reps) AS avg_reps_per_week
FROM weekly_volume
GROUP BY muscle_group
ORDER BY avg_reps_per_week DESC;
