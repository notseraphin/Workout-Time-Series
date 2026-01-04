-- Aggregate exercise progression by muscle group
DROP TABLE IF EXISTS muscle_progression;

CREATE TABLE muscle_progression AS
SELECT 
    ep.muscle_group,
    COUNT(ep.delta_1rm) AS num_exercises,
    AVG(ep.delta_1rm) AS avg_delta_1rm,
    SUM(ep.delta_1rm) AS total_delta_1rm
FROM exercise_progression ep
WHERE ep.delta_1rm IS NOT NULL
GROUP BY ep.muscle_group
ORDER BY avg_delta_1rm DESC;
