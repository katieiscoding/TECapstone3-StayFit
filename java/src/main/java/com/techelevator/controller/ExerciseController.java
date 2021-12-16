package com.techelevator.controller;

import com.techelevator.dao.*;
import com.techelevator.model.ExerciseDTO;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin
public class ExerciseController {

    private ExerciseDao exerciseDao;

    public ExerciseController(ExerciseDao exerciseDao) {
        this.exerciseDao = exerciseDao;
    }

    @PreAuthorize("isAuthenticated()")
    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(path = "/exercise/add", method = RequestMethod.POST)
    public void addExercise(@RequestBody ExerciseDTO exercise){
        exerciseDao.createExercise(exercise);
    }
    @PreAuthorize("isAuthenticated()")
    @RequestMapping(path = "/exercise/all", method = RequestMethod.GET)
    public List<ExerciseDTO> getAllExercises() {
       return exerciseDao.getAllExercises();
    }



}
