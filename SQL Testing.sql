SELECT * FROM exercise

SELECT exercise_id, exercise_name, exercise_target, weight, reps, exercise_duration, creator_name 
FROM exercise
WHERE exercise_id = 6

SELECT exercise_id, exercise_name, exercise_target, weight, reps, exercise_duration, creator_name
FROM exercise
WHERE exercise_name = 'push'

INSERT INTO exercise (exercise_name, exercise_target, weight, reps, exercise_duration, creator_name)
VALUES ('push', 'legs', 10, 2, 3, 'chris') RETURNING exercise_id;

