<template>
 <section class="main">  
  <div class="customize">
    <h1 class="h3 headline mb-3 font-weight-normal">Custom Workout</h1>
   <div class="selections">

   <div class="selectionBox">
     <div class="selectionPic">
      <img id="trainerSelect" src="../assets/trainer1.png">
      </div>
      <div class="multiSelect">
      <label for="standard-select">Select Trainer</label>
      <div class="select">
        <select id="standard-select" v-model="selectedTrainers" v-on:change="onFilter">
          <option v-for="trainer in this.trainers" v-bind:key="trainer" :value="trainer">{{trainer}}</option>
        </select>
        <span class="focus"></span>
      </div>
     </div>
   </div>

   <div class="selectionBox">
     <div class="selectionPic">
       <img id="targetSelect" src="../assets/target-whole-body.png">
     </div>
     <div class="multiSelect">
      <label for="standard-select">Select Target(s)</label>
      <div class="select">
        <select id="standard-select" v-model="selectedTarget" v-on:change="onFilter">
          <option value="">All</option>
          <option v-for="target in this.targets" v-bind:key="target" :value="target">{{target}}</option>
        </select>
        <span class="focus"></span>
      </div>
     </div>
   </div>

   <div class="selectionBox">
     <div class="selectionPic">
       <img id="durationSelect" src="../assets/duration.png">
     </div>
     <div class="multiSelect">
      <label for="standard-select">Select Duration</label>
      <div class="select">
        <input type="number" id="standard-select" v-model="selectedDuration"/> 
          
        <span class="focus"></span>
      </div>
     </div>
   </div>
   </div>

 
  <div class="mt-2">
    <button
      class="btn btn-lg btn-primary btn-block my-2"
      v-on:click="generateWorkout">
      Generate Workout
    </button>
  </div>
  </div>
  <div class="customize2">
  <h1 class="h3 headline subhead mb-3 font-weight-normal">Want More Options?</h1>
  <div class="two-button-row"> 
  <div class="mt-2">
     <img class="miniPic" id="todays-workout" src="../assets/todays-workout.png">
    <a href="exercise-list"><button
      class="btn btn-lg btn-primary btn-block my-2"
      type="submit">
      Choose From Exercise List
    </button></a>
  </div>
  <div class="mt-2">
    <img class="miniPic" id="horseshoe" src="../assets/feeling-lucky.png">
    <a href=""><button id="lucky" class="btn btn-lg btn-primary btn-block my-2"
      type="submit">
      I'm Feeling Lucky!
    </button></a>
  </div>
  </div>
  </div>
 </section>

</template>

<script>
import ExerciseService from '../services/ExerciseService.js';
import WorkoutService from '../services/WorkoutService.js';


export default {
  name: 'customize',
  data(){
    return{
      exercises:[],
      filteredExercises:[],
      targets:[],
      durationOptions:[],
      selectedTarget:"",
      selectedDuration:"",
      trainers:[],
      selectedTrainers:""
    }
  },
  methods: {
    onFilter() { 
      this.filteredExercises=this.exercises;

       if(this.selectedTrainers) {
          this.filteredExercises=this.filteredExercises.filter(x=>x.creatorName===this.selectedTrainers);
       }

      if(this.selectedTarget) {
          this.filteredExercises=this.filteredExercises.filter(x=>x.exerciseTarget===this.selectedTarget);
          
      }
      if(this.selectedDuration) {
        this.filteredExercises=this.filteredExercises.filter(x=>x.exerciseDuration===this.selectedDuration);
      }


    },
    generateWorkout() {
      WorkoutService.generateWorkout(this.selectedDuration, this.selectedTrainers, [this.selectedTarget])
      .then(exercises=>{
        this.$store.commit("SET_WORKOUT",exercises.data);
        this.$router.push({name:"workout"});


      })




    },
    
    getExercises() {
      try{
      ExerciseService.listExercises().then((resp)=>{
        this.exercises=resp.data;
        this.filteredExercises=this.exercises;

        let trainersArray=this.exercises.map(e=>e.creatorName);
        this.trainers=Array.from(new Set(trainersArray)).sort();
      

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
  

  
  }


  
  


</script>

<style>
*,
*::before,
*::after {
  box-sizing: border-box;
}

@media only screen and (max-width: 768px) {

.selections {
padding: 0 0 30px 0 !important;
display: flex;
flex-direction: column;
align-items: center;
}

.selectionBox {
  width: 50%;
  padding-bottom: 30px;
}

.two-button-row {
  display: flex;
  flex-direction: column; 
  align-content: center;
  align-items: center;
  row-gap: 10px !important;
  padding-bottom: 0 !important;
}

.miniPic {
  width: 30% !important;
  padding-bottom: 10px;
}
}


.mt-2 {
  display: flex;
  flex-direction: column;
  align-items: center;
}

select {
  width: 100%;
  min-width: 22ch;
  max-width: 22ch;
  border: 1px solid var(--select-border);
  border-radius: 0.25em;
  padding: 0.25em 0.5em;
  font-size: 1.1rem;
  cursor: pointer;
  line-height: 1.5;
  background-color: #fff;
  background-image: linear-gradient(to top, #f9f9f9, #fff 33%);
}

label {
  font-family: 'Crete Round', serif;
  text-align: center;
  font-size: 1.5rem;
  padding-bottom: 5px;
}

:root {
  --select-border: #4C241D;
  --select-focus: blue;
  --select-focus-label: black;
  --select-arrow: var(--select-border);
}

.select {
  display: grid;
  grid-template-areas: "select";
  align-items: center;
  position: relative;
}

.multiSelect {
  display: flex;
  flex-basis: 100%;
  flex-direction: column;
  align-items: center;
  justify-content: flex-start;
}

.selections {
padding: 30px 0;
display: flex;
}

#trainerSelect, #targetSelect, #durationSelect {
  width: 70%;
}

#lucky {
  background-color: #a9ba5a;
  margin-bottom: 60px;
}

.selectionPic {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.selectionBox {
  padding-bottom: 30px;
}

.two-button-row {
  display: flex;
  justify-content: center;
  width: 100%;
  gap: 0px;
  padding: 20px 0 0 0;
}

select:focus + .focus {
  position: absolute;
  top: -1px;
  left: -1px;
  right: -1px;
  bottom: -1px;
  border: 2px solid var(--select-focus);
  border-radius: inherit;
}

.miniPic {
  width: 30%;
  padding-bottom: 10px;
}

#horseshoe {
  margin-left: -13px;
}

.customize {
  padding: 25px 0 50px 0;
}

.customize2 {
  border-top: 5px solid #4c241D;
  border-bottom: 5px solid #4c241D;
  background-color: #FFEC95;
  min-width: 100%;
  padding-top: 25px;
  margin-bottom: 50px;
}

</style>
