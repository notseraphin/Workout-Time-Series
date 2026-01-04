-- Populate Workout table
INSERT INTO Workout(workout_date, workout_name, duration)
SELECT DISTINCT workout_date, workout_name, duration
FROM raw_workouts;

-- Populate Exercise table with correct muscle groups
INSERT INTO Exercise(name, muscle_group)
SELECT DISTINCT exercise_name,
       CASE
           -- Quads
           WHEN exercise_name ILIKE '%Leg Extension%' 
                OR exercise_name ILIKE '%Squat%' THEN 'Quads'
           
           -- Hamstrings / Glutes
           WHEN exercise_name ILIKE '%Leg Curl%' 
                OR exercise_name ILIKE '%Deadlift%'
                OR exercise_name ILIKE '%Laying%'
                OR exercise_name ILIKE '%Back Extension%' THEN 'Hamstrings'
           
           -- Adductors
           WHEN exercise_name ILIKE '%Adductor%' THEN 'Adductors'
           -- Calves
           WHEN exercise_name ILIKE '%Calf%' THEN 'Calves'
           
           -- Chest
           WHEN exercise_name ILIKE '%Chest Press%' 
                OR exercise_name ILIKE '%Bench%' 
                OR exercise_name ILIKE '%Pec%' THEN 'Chest'
           
           -- Lats
           WHEN exercise_name ILIKE '%Pull%' THEN 'Lats'

           --Upperback
           WHEN exercise_name ILIKE '%Row%' THEN 'Upperback'
           
           -- Biceps
           WHEN exercise_name ILIKE '%Incline curl%' 
                OR exercise_name ILIKE '%Bicep%'
                OR exercise_name ILIKE '%Hammer%'
                OR exercise_name ILIKE '%Preacher%' THEN 'Biceps'
           
           -- Triceps
           WHEN exercise_name ILIKE '%Tricep%' 
                OR exercise_name ILIKE '%Dip%'
                OR exercise_name ILIKE '%Skullcrusher%'
                OR exercise_name ILIKE '%Arm Extension%' THEN 'Triceps'
           
           -- Shoulders
           WHEN exercise_name ILIKE '%Shoulder Press%' 
                OR exercise_name ILIKE '%Lateral Raise%' 
                OR exercise_name ILIKE '%Reverse Fly%' THEN 'Shoulders'
           
           -- Abs
           WHEN exercise_name ILIKE '%Crunch%' 
                OR exercise_name ILIKE '%Hanging%' THEN 'Abs'
           
           ELSE 'Other'
       END
FROM raw_workouts
WHERE exercise_name NOT ILIKE '%Rest Timer%';


-- Populate WorkoutSet table, skipping Rest Timer sets
INSERT INTO WorkoutSet(workout_id, exercise_id, set_order, weight, reps, distance, seconds, notes)
SELECT DISTINCT
    w.id AS workout_id,
    e.id AS exercise_id,
    rw.set_order,
    rw.weight,
    rw.reps,
    rw.distance,
    rw.seconds,
    rw.notes
FROM raw_workouts rw
JOIN Workout w 
    ON rw.workout_date = w.workout_date 
   AND rw.workout_name = w.workout_name
JOIN Exercise e 
    ON rw.exercise_name = e.name
WHERE rw.exercise_name NOT ILIKE '%Rest Timer%';
