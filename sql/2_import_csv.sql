-- Import CSV into raw_workouts
COPY raw_workouts(workout_date, workout_name, duration, exercise_name, set_order, weight, reps, distance, seconds, notes, workout_notes, rpe)
FROM 'C:/Users/serap/WorkoutTimeSeries/strong_workouts.csv' 
DELIMITER ',' 
CSV HEADER NULL '';

