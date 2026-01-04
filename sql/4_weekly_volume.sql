COPY (
    -- Aggregate weekly volume by muscle group
    WITH unique_sets AS (
        SELECT DISTINCT
            ws.workout_id,
            ws.exercise_id,
            ws.set_order,
            ws.reps
        FROM WorkoutSet ws
        JOIN Exercise e ON ws.exercise_id = e.id
        WHERE e.name NOT ILIKE '%Rest Timer%'
    )
    SELECT
        EXTRACT(YEAR FROM w.workout_date) AS year,
        EXTRACT(WEEK FROM w.workout_date) AS week,
        e.muscle_group,
        COUNT(us.set_order) AS total_sets,
        SUM(us.reps) AS total_reps
    FROM unique_sets us
    JOIN Workout w ON us.workout_id = w.id
    JOIN Exercise e ON us.exercise_id = e.id
    GROUP BY year, week, e.muscle_group
    ORDER BY year, week, e.muscle_group
) TO 'C:/Users/serap/WorkoutTimeSeries/weekly_volume.csv'
WITH CSV HEADER;
