package com.techelevator.dao;

import com.techelevator.model.ExerciseDTO;
import org.springframework.stereotype.Component;

import java.util.List;

public interface ExerciseDao {

    ExerciseDTO getExercise(long exerciseID);

    List<ExerciseDTO> getExercisesByName(String exerciseName);

    ExerciseDTO createExercise(ExerciseDTO addExerciseDTO);

    void updateExercise(ExerciseDTO exerciseDTO);

    void deleteExercise(long exerciseId);

    List<ExerciseDTO> getAllExercises();
}
