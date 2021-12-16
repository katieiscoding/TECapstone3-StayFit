package com.techelevator.dao;

import ch.qos.logback.core.encoder.EchoEncoder;
import com.techelevator.model.ExerciseDTO;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
@Component
public class JdbcExerciseDao implements ExerciseDao {

    private JdbcTemplate jdbcTemplate;

    public JdbcExerciseDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }


    @Override
    public ExerciseDTO getExercise(long exerciseID) {
        ExerciseDTO exercise = null;
        String sql = "SELECT exercise_id, exercise_name, exercise_target, weight, reps, exercise_duration, creator_name " +
                    "FROM exercise " +
                    "WHERE exercise_id = ?;";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, exerciseID);
        if (results.next()) {
            exercise = mapRowToExerciseDTO(results);
        }
        return exercise;
    }

    @Override
    public List<ExerciseDTO> getAllExercises (){
        ExerciseDTO exercise = null;
        List<ExerciseDTO> listOfExercises = new ArrayList<>();
        String sql = "SELECT * FROM exercise ";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql);
        while (results.next()) {
            exercise = mapRowToExerciseDTO(results);
            listOfExercises.add(exercise);
        }
        return listOfExercises;


    }

    @Override
    public List<ExerciseDTO> getExercisesByName(String exerciseName) {
        List<ExerciseDTO> exercises = new ArrayList<>();
        String sql = "SELECT exercise_id, exercise_name, exercise_target, weight, reps, exercise_duration, creator_name " +
                    "FROM exercise " +
                    "WHERE exercise_name = ?;";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, exerciseName);
        while (results.next()) {
            exercises.add(mapRowToExerciseDTO(results));
        }
        return exercises;
    }

    @Override
    public ExerciseDTO createExercise(ExerciseDTO exercise) {
        String sql = "INSERT INTO exercise (exercise_name, exercise_target, weight, reps, exercise_duration, creator_name)" +
                    "VALUES (?, ?, ?, ?, ?, ?) RETURNING exercise_id;";
        Long newId = jdbcTemplate.queryForObject(sql, Long.class, exercise.getExerciseName(),
                exercise.getExerciseTarget(), exercise.getWeight(), exercise.getReps(), exercise.getExerciseDuration(),
                exercise.getCreatorName());
        return getExercise(newId);
    }

    @Override
    public void updateExercise(ExerciseDTO exercise) {
        String sql = "UPDATE exercise " +
                    "SET exercise_name = ?, exercise_target = ?, weight = ?, reps =?, exercise_duration = ?, creator_name = ? " +
                    "WHERE exercise_id = ?;";
        jdbcTemplate.update(sql, exercise.getExerciseName(), exercise.getExerciseTarget(), exercise.getWeight(),
                exercise.getReps(), exercise.getExerciseDuration(), exercise.getCreatorName());
    }

    public void deleteExercise(long exerciseId) {
    String sql = "DELETE FROM exercise WHERE exercise_id = ?;";
    jdbcTemplate.update(sql, exerciseId);
    }

    private ExerciseDTO mapRowToExerciseDTO(SqlRowSet rowSet) {
        ExerciseDTO exercise = new ExerciseDTO();
        exercise.setExerciseId(rowSet.getLong("exercise_id"));
        exercise.setExerciseName(rowSet.getString("exercise_name"));
        exercise.setExerciseTarget(rowSet.getString("exercise_target"));
        exercise.setWeight(rowSet.getLong("weight"));
        exercise.setReps(rowSet.getLong("reps"));
        exercise.setExerciseDuration(rowSet.getLong("exercise_duration"));
        exercise.setCreatorName(rowSet.getString("creator_name"));
        exercise.setExerciseDescription(rowSet.getString("exercise_description"));
        return exercise;
    }
}
