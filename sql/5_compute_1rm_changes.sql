-- Compute estimated 1RM per exercise per workout using Epley formula: 1RM = weight * (1 + reps / 30)

DROP TABLE IF EXISTS exercise_1rm;

CREATE TABLE exercise_1rm AS
SELECT 
    ws.exercise_id,
    e.name AS exercise_name,
    e.muscle_group,
    ws.workout_id,
    w.workout_date,
    MAX(ws.weight * (1 + ws.reps/30)) AS estimated_1rm
FROM WorkoutSet ws
JOIN Exercise e ON ws.exercise_id = e.id
JOIN Workout w ON ws.workout_id = w.id
GROUP BY ws.exercise_id, e.name, e.muscle_group, ws.workout_id, w.workout_date;

-- Compute delta 1RM for each exercise compared to previous workout
DROP TABLE IF EXISTS exercise_progression;

CREATE TABLE exercise_progression AS
WITH ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY exercise_id ORDER BY workout_date) AS rn
    FROM exercise_1rm
)
SELECT 
    curr.exercise_id,
    curr.exercise_name,
    curr.muscle_group,
    curr.workout_id,
    curr.workout_date,
    curr.estimated_1rm,
    curr.estimated_1rm - prev.estimated_1rm AS delta_1rm
FROM ranked curr
LEFT JOIN ranked prev
  ON curr.exercise_id = prev.exercise_id
 AND curr.rn = prev.rn + 1;
