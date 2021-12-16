package com.techelevator.dao;

import com.techelevator.model.ExerciseTrainer;
import com.techelevator.model.Workout;


import java.security.Principal;
import java.util.List;
public interface WorkoutDAO {

    List<ExerciseTrainer> generateWorkout(String creatorName, String[] bodyTargetIds, int totalTime);
    public boolean saveCompletedWorkout(List<ExerciseTrainer> exerciseTrainers, Principal principal);
    List<Workout> getUserWorkouts(String username);
}
