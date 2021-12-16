<template>
<section class="main">
      <div class="workout-history">
               <h1 class="headline mb-3 font-weight-normal">Areas of Focus</h1>
               <h4 class="subhead">Select a focus for your workout; when you're ready to exercise, tap "Create Workout."</h4>

      <div class="filter">
        <div class="filter-labels">
          <div id="filter-image">
          <img id="filter-pic" src="../assets/filter.png">
          </div>
          <div id="filter-text">
          <p id="filter-by">Filter by: </p>
          </div>
        </div>

      <div id="dropdowns">
          <div class="filter-selections">
        <div class="multiSelect" id="target-area-filter">
        <label for="standard-select">Target Area </label>
        <div class="select">
        <select id="standard-select" v-model="selectedTarget" v-on:change="onFilter">
          <option value="">All</option>
          <option v-for="target in this.targets" v-bind:key="target" :value="target">{{target}}</option>
        </select>
        <span class="focus"></span>
      </div>
        </div>
      </div>

      <div class="filter-selections">
      <div class="multiSelect" id="duration-filter">
      <label for="standard-select">Duration </label>
      <div class="select">
        <select id="standard-select" v-model="selectedDuration" v-on:change="onFilter"> 
          <option value="">All</option>
          <option v-for="duration in this.durationOptions" v-bind:key="duration" :value="duration">{{duration}}</option>
         
        </select>
        <span class="focus"></span>
      </div>
     </div>
      </div>
     </div>
        
      </div>

      <div class="all-workouts">
        <exercise-card-component v-for="exercise in this.filteredExercises" v-bind:key="exercise.exercise_id"
         v-bind:exercise="exercise" v-on:click="addToWorkout(exercise)">
        </exercise-card-component>
      </div>
      <div class="last-button">
      <button class="btn" v-on:click="generateWorkout">Generate Workout</button>
      </div>
      </div>
   </section>
</template>

<script>  
import ExerciseCardComponent from '../components/ExerciseCardComponent.vue';
import ExerciseService from '../services/ExerciseService.js';


export default {
  name: 'exercise-list',
  components: {ExerciseCardComponent},
  data(){
    return{
      exercises:[],
      selectedExercises:[],
      filteredExercises:[],
      targets:[],
      durationOptions:[],
      selectedTarget:"",
      selectedDuration:""
    }
  },
  methods: {

    addToWorkout(exercise) {
      console.log(exercise);
      this.selectedExercises.push(exercise);
    },

     generateWorkout() {
        this.$store.commit("SET_WORKOUT",this.filteredExercises.map(x=>{
            return {
              name:x.exerciseName,
              id:x.exerciseId,
              description:x.exerciseDescription,
              bodyTargetId:x.exerciseTarget,
              suggestedWeight:x.weight,
              time:x.exerciseDuration,
              reps:x.reps,
              trainerName:x.creatorName
            };

        }));
        this.$router.push({name:"workout"});  
    },
    
    onFilter() { 
      this.filteredExercises=this.exercises;
      if(this.selectedTarget) {
          this.filteredExercises=this.filteredExercises.filter(x=>x.exerciseTarget===this.selectedTarget);
          
      }
      if(this.selectedDuration) {
        this.filteredExercises=this.filteredExercises.filter(x=>x.exerciseDuration===this.selectedDuration);
      }
    },

    getExercises() {
      try{
      ExerciseService.listExercises().then((resp)=>{
        this.exercises=resp.data;
        this.filteredExercises=this.exercises;
      

        let targetsArray=this.exercises.map(e=>e.exerciseTarget);
        this.targets=Array.from(new Set(targetsArray)).sort();
        

        let durationsArray=this.exercises.map(e=>e.exerciseDuration);
        this.durationOptions=Array.from(new Set(durationsArray)).sort();


        console.log(resp)
      })
      }catch(e) {
        console.error(e);
      }
    }

  },
  created() {
    this.getExercises()

  }
  
  
}; 
</script>

<style>
  * {
    box-sizing: border-box;
  }

 @import url('https://fonts.googleapis.com/css2?family=Crete+Round&family=Lato:wght@300;400;700&display=swap');
  
  @media only screen and (max-width: 768px) {
  .exercise-list-card {
      flex-direction: column;
      width: 100% !important;
      align-items: flex-start;
      justify-content: flex-start;
      margin-left: 20px !important;
      margin-right: 20px !important;
  }

  .workout-history {
      flex-direction: row;
  }

  .filter {
    display: flex;
    width: 100% !important;
    flex-direction: column;
    align-items: center;
    align-content: center;
    font-size: 12px;
    margin-bottom: 20px !important;
  }

  #dropdowns {
    display: flex;
    flex-direction: column !important;
    align-items: center;
    margin-top: 10px;
    margin-bottom: 0 !important;
    gap: 0px !important;
 
  }

  #filter-image {
  display: flex;
  justify-content: flex-end;
  width: 60px !important;
  height: auto;
}

#filter-text {
  width: 50%;
  justify-content: start;
  font-size: 200%;
  padding-left: 0;
}

#filter-text p {
  text-align: left;
}

#filter-pic {
  width: 75px !important;
  height: auto;
}

.filter-labels {
  display: flex;
  width: 100% !important;
  justify-content: center;
  align-items: center;

  padding-right: 0 !important;
}

.filter-selections{
  margin-bottom: 20px;
}



  }



#filter-image {
  display: flex;

}

#filter-text {
  font-weight: bold;
  font-size: 140%; 
}

#filter-pic {
  width: 90px;
  height: auto;
}

.filter {
  display: flex;
  justify-content: center;
  align-content: center;
  width: 750px;
  height: auto;
  margin: 0 auto 35px auto;

}

.filter-labels {
  display: flex;
  align-content: center;
  justify-content: end;
  width: 30%;
  align-items: center;
  padding-right: 45px;
}

#dropdowns {
  display: flex;
  flex-direction: row;
  width: 100%;
  flex-basis: 50%;
  gap: 25px;
}

select {
  text-align: center;
  padding-left: 20px;
}

option {
  padding-left: 0 !important;
}

.filter-selections {
  display: flex;
  align-items: center;
}

 .exercise-background {
   background-color: #A9BA5A;
   width: 100%;
 }
  
  .dynamic-pic {
    width: 90px;
    height: auto;
  }

  .dynamic-name {
    margin: 10px 0;
  }

  .exercise-details {
    margin-bottom: 30px;
  }

  .dynamic-target {
    padding-left: 10px;
  }

  .dynamic-weight {
    padding-left: 10px;
  }

  .dynamic-reps {
    padding-left: 10px;
  }

  .dynamic-duration {
    padding-left: 10px;
  }

  .dynamic-desc {
    text-align: left !important;
    margin-bottom: 0 !important;
  }

  .detail-name {
    display: flex;
    height: 30px;
    align-items: baseline;
  }
  
  .all-workouts {
    width: 100%;
    display: flex;
    flex-flow: row wrap;
    justify-content: center;
    justify-items: flex-start;
    align-items: flex-start;
  }
  
  .workout-history {
    padding: 25px;
    width: 100%;
    display: flex;
    flex-direction: column;
    align-content: center;
    justify-items: center;
  }
  
  .exercise-list-card {
      display: flex;
      width: 25%;
      min-width: 210px;
      max-width: 300px;
      flex-direction: column;
      align-items: center;
      margin: 0 20px 35px;
      padding: 15px 10px 15px;
      border: 5px solid #4C241D;
      border-radius: 12px;
      background-color: #ffce56;
      text-align: center;
  }

  .exercise-list-card p {
      text-align: center;
      margin-top: 0 !important;
  }

  .last-button {
    display: flex;
    justify-content: center;
  }
  
  </style>