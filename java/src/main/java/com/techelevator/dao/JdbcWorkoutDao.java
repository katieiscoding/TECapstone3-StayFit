package com.techelevator.dao;


import com.techelevator.model.Authority;
import com.techelevator.model.ExerciseDTO;
import com.techelevator.model.ExerciseTrainer;
import com.techelevator.model.Workout;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Component

public class JdbcWorkoutDao implements WorkoutDAO {

    private JdbcTemplate jdbcTemplate;

    public JdbcWorkoutDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<ExerciseTrainer> generateWorkout(String creatorName, String[] bodyTargetIds, int totalTime) {
        List<ExerciseTrainer> allExerciseTrainers = new ArrayList<>();

        String SQL = "SELECT exercise_id, exercise_name, reps, exercise_duration, " +
                "exercise_target, weight, exercise_description, creator_name FROM exercise " +
                "WHERE creator_name = ? ";

        SqlRowSet sqlRowSet = jdbcTemplate.queryForRowSet(SQL, creatorName);

        while (sqlRowSet.next()) {
            allExerciseTrainers.add(mapRowToExercise(sqlRowSet));
        }

         // filter by muscle workout target
        if (bodyTargetIds.length > 0) {
           allExerciseTrainers = filterByBodyTarget(allExerciseTrainers, bodyTargetIds);

        }

        Collections.shuffle(allExerciseTrainers);
        int timeCounter = 0;
        List<ExerciseTrainer> filteredExerciseTrainers = new ArrayList<>();

        // filter by workout time

        for (int i = 0; i < allExerciseTrainers.size(); i++) {
            timeCounter += allExerciseTrainers.get(i).getTime();
            if (totalTime - timeCounter < 10 || totalTime - timeCounter < -10) {
                filteredExerciseTrainers.add(allExerciseTrainers.get(i));
            }
        }
        return filteredExerciseTrainers;

        }

    @Override
    public boolean saveCompletedWorkout(List<ExerciseTrainer> exerciseTrainers, Principal principal) {
        return false;
    }

    @Override
    public List<Workout> getUserWorkouts(String exerciseTarget){

        List<Workout> userWorkouts = new ArrayList<>();
        String sql= "SELECT * FROM workouts ";
        SqlRowSet sqlRowSet= jdbcTemplate.queryForRowSet(sql, exerciseTarget);
        while(sqlRowSet.next()){
            userWorkouts.add(mapRowToWorkout(sqlRowSet));
        }
        return userWorkouts;
    }

    private List<ExerciseTrainer> filterByTrainer(List<ExerciseTrainer> allExerciseTrainers, int[] trainerIds){
        List<ExerciseTrainer> updatedExerciseTrainers = new ArrayList<>();
        for(int i = 0; i < allExerciseTrainers.size(); i++){
            for(int j=0; j< trainerIds.length; j++){
                if(trainerIds[j] == allExerciseTrainers.get(i).getTrainerId()){
                    updatedExerciseTrainers.add(allExerciseTrainers.get(i));
                }
            }
        }
        return updatedExerciseTrainers;

    }
    private List<ExerciseTrainer> filterByBodyTarget(List<ExerciseTrainer> allExerciseTrainers, String[] bodyTargetIds){
        List<ExerciseTrainer> updatedExerciseTrainers = new ArrayList<>();
        for(int i = 0; i < allExerciseTrainers.size(); i++){
            for(int j=0; j< bodyTargetIds.length; j++){
                if(bodyTargetIds[j].equals( allExerciseTrainers.get(i).getBodyTargetId())){
                    updatedExerciseTrainers.add(allExerciseTrainers.get(i));
                }
            }
        }
        return updatedExerciseTrainers;
    }
    private int getNewWorkoutId(){
        String sql = "SELECT workout_id FROM workout ORDER BY workout_id DESC LIMIT 1 ";
        SqlRowSet sqlRowSet = jdbcTemplate.queryForRowSet(sql);
        int newWorkoutId = 1;
        if(sqlRowSet.next()){
            newWorkoutId+= sqlRowSet.getInt("workout_id");
        }
        return newWorkoutId;
    }
    private int getTotalTime(List<ExerciseTrainer> exerciseTrainers){
        int sum = 0;
        for(ExerciseTrainer exerciseTrainer: exerciseTrainers){
            sum += exerciseTrainer.getTime();
        }
        return sum;

    }

    public ExerciseTrainer mapRowToExercise(SqlRowSet rowSet) {
        ExerciseTrainer exercise = new ExerciseTrainer();
        exercise.setId(rowSet.getInt("exercise_id"));
        exercise.setName(rowSet.getString("exercise_name"));
        exercise.setReps(rowSet.getInt("reps"));
        exercise.setTime(rowSet.getInt("exercise_duration"));
        exercise.setBodyTargetId(rowSet.getString("exercise_target"));
        exercise.setSuggestedWeight(rowSet.getInt("weight"));
        exercise.setDescription(rowSet.getString("exercise_description"));
        exercise.setTrainerName(rowSet.getString("creator_name"));
        return exercise;


    }

    public Workout mapRowToWorkout(SqlRowSet rowSet) {
        Workout workout = new Workout();
        workout.setWorkoutId(rowSet.getInt("workout_id"));
        workout.setExerciseId(rowSet.getInt("exercise_id"));
        workout.setSetsCompleted(rowSet.getInt("sets_completed"));
        workout.setRepsCompleted(rowSet.getInt("reps_completed"));
        workout.setTimeCompleted(rowSet.getInt("time_completed"));
        workout.setTrainerId(rowSet.getInt("trainer_id"));
        workout.setWeightCompleted(rowSet.getInt("weight_completed"));
        workout.setTotalTime(rowSet.getInt("total_time"));
        String dateAsString = rowSet.getString("date_saved");
        workout.setDateSaved(LocalDate.parse(dateAsString));
        workout.setTrainerName(rowSet.getString("trainer_name"));
        workout.setExerciseName(rowSet.getString("exercise_name"));
        return workout;
    }
}


