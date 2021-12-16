<template>
         <div class="workout-card">
            <div class="details">
                <h2 class="workout-label">Date & Time:</h2>
                <p id="dynamic-timestamp">{{workout.workoutTimestamp}}</p>
                <h2 class="workout-label">Exercises:</h2>
                <p id="dynamic-exercise-name">
                    <ul>
                        <!-- how do we connect this and pull the info? a join?? -->
                        <li>{{workout_exercise.exerciseName}}</li>
                    </ul>
                </p>
                <h2 class="workout-label">Duration:</h2>
                <p id="dynamic-duration">{{workout.workoutDuration}} min.</p>
            </div>
         </div>
</template>

<script>  
export default {
    props: {workout:Object, exercise:Object},
    name: 'workout-card'
}; 
</script>

<style>
 
  </style>