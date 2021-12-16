<template>
<section class="main">
      <div class="workout">
               <h1 class="headline mb-3 font-weight-normal">Your Workout</h1>
               <h4 class="subhead">Tap the circle to check off each completed exercise.</h4>
       
      <div class="all-cards" v-if="show">
         <exercise-card-check v-for="exercise in this.workoutExercises" v-bind:key="exercise.id" v-bind:exercise="exercise">
         </exercise-card-check>
        <div class="button-row">
      <!-- <button class="btn">Log Completed Workout</button> -->
      <a href="customize"><button class="btn">Choose New Exercises</button></a>
        </div>
      </div>  
      </div>
   </section>
</template>

<script>  
import ExerciseService from '../services/ExerciseService.js';

const { default: ExerciseCardCheck }=require('../components/ExerciseCardCheck.vue')

export default {
  components: { ExerciseCardCheck }, 
  name: 'workout',

data() {
  return {
     workoutExercises:[],
     show: false,
  }
},
 methods: {

    refreshComponent() {
      this.keep += 1;
    },

    getExercises() {
      try{
      ExerciseService.listExercises().then((resp)=>{
        this.workoutExercises=resp.data
        console.log(resp)
      })
      }catch(e) {
        console.error(e);
      }
    }

  },
  mounted() {
      this.workoutExercises=this.$store.state.workout;
      console.log(this.workoutExercises)
      if(this.workoutExercises.length > 0) {
        this.show = true;
      }

    }
};
</script>


<style>

@import url('https://fonts.googleapis.com/css2?family=Crete+Round&family=Lato:wght@300;400;700&display=swap');

@media only screen and (max-width: 768px) {
    .exercise-card {
        flex-direction: column;
        width: 380px;
        padding: 0 10px;
    }

    .button-row {
      padding-left: 0 !important;
      display: flex;
      flex-direction: column;
      text-align: center;
      padding-top: 10px;
    }

    .all-cards {
      display: flex;
      flex-flow: column wrap;
      justify-content: center;
      align-items: center;
      min-height: 100vh !important;
    }

    .description {
        padding: 0 25px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }
    
    .checkbox {
        margin: 0 !important;
        padding: 0 0 10px 0 !important;
        width: 100px !important;
    }

    .smallPic {
        width: 150px;
        height: auto;
        padding: 0;
    }
}


.button-row {
  padding-left: 25px;
  margin-bottom: 50px;
  display: flex;
  justify-content: center;
  text-align: center;
}

.workout {
    padding: 25px;
    display: flex;
    flex-direction: column;
}

.all-cards {
  width: 100%;
}

.smallPic {
    width: 220px;
    height: auto;
    padding: 0 25px;
}

.checkbox {
    width: 150px;
    height: auto;
    padding: 25px;
    margin-bottom: 8px;
}

.exercise-card {
    display: flex;
    align-items: center;
    margin: 0 25px 25px;
    border: 5px solid #4C241D;
    border-radius: 12px;
    background-color: #ffce56;
    max-width: 1000px;
}

.description {
    padding-right: 20px;
    padding-bottom: 10px;
}

.description p {
  text-align: left;
  margin-top: 0 !important;
}

#dynamic-exercise {
  padding-bottom: 10px;
  margin-bottom: 0 !important;
}

</style>