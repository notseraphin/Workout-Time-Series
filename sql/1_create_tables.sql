
-- drop tables
DROP TABLE IF EXISTS WorkoutSet CASCADE;
DROP TABLE IF EXISTS Workout CASCADE;
DROP TABLE IF EXISTS Exercise CASCADE;
DROP TABLE IF EXISTS raw_workouts;

-- Drop intermediate tables from previous runs
DROP TABLE IF EXISTS exercise_1rm CASCADE;
DROP TABLE IF EXISTS exercise_progression CASCADE;
DROP TABLE IF EXISTS muscle_progression CASCADE;


-- Raw table to hold CSV data
CREATE TABLE raw_workouts (
    workout_date TIMESTAMP,
    workout_name VARCHAR(100),
    duration VARCHAR(20),
    exercise_name VARCHAR(100),
    set_order VARCHAR(20),
    weight NUMERIC(6,2),
    reps NUMERIC(6,2),
    distance NUMERIC(6,2),
    seconds NUMERIC(6,2),
    notes TEXT,
    workout_notes TEXT,
    rpe NUMERIC(3,1)
);

-- Normalized tables
CREATE TABLE Workout (
    id SERIAL PRIMARY KEY,
    workout_date TIMESTAMP NOT NULL,
    workout_name VARCHAR(100),
    duration VARCHAR(20)
);

CREATE TABLE Exercise (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    muscle_group VARCHAR(50)
);

CREATE TABLE WorkoutSet (
    id SERIAL PRIMARY KEY,
    workout_id INT NOT NULL REFERENCES Workout(id),
    exercise_id INT NOT NULL REFERENCES Exercise(id),
    set_order VARCHAR(10),
    weight NUMERIC(6,2),
    reps NUMERIC(6,2),
    distance NUMERIC(6,2),
    seconds NUMERIC(6,2),
    notes TEXT
);
