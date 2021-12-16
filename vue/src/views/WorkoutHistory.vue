<template>
<section class="main">
      <div class="workout-history">
               <h1 class="headline mb-3 font-weight-normal">Workout History</h1>
               <h4 class="subhead">Look at all you've accomplished!</h4>
      <div class="all-workouts">
          <workout-card></workout-card>
    
         <div class="workout-card">
            <div class="details">

                <h2 class="workout-label">Date & Time:</h2>
                <p id="dynamic-timestamp">07/02/2021, 7:30 AM</p>

                <h2 class="workout-label">Exercises:</h2>
                <p id="dynamic-exercise-name">
                    <ul>
                        <li>This is the</li>
                        <li>Example Card</li>
                        <li>exercise name</li>
                        <li>exercise name</li>
                    </ul>
                </p>

                <h2 class="workout-label">Duration:</h2>
                <p id="dynamic-duration">15 minutes</p>

            </div>
         </div>

                
      </div>  
      </div>
   </section>
</template>

<script>  
import WorkoutCard from '../components/WorkoutCard.vue';
import WorkoutService from '../services/WorkoutService.js';


export default {
  name: 'workout-history',
  components: {WorkoutCard},
  data(){
    return{

   // I think this array needs to specify this.workouts or some way to tie it to the user
      workouts:[]
    }
  },
  methods: {
    getUserWorkouts() {
      try{
      WorkoutService.getSavedUserWorkouts().then((resp)=>{
        this.workouts=resp.data
        console.log(resp)
      })
      }catch(e) {
        console.error(e);
      }
    }

  },
  created() {
    this.getUserWorkouts()

  }
}; 
</script>

<style>
  * {
    box-sizing: border-box;
  }
  
  @import url('https://fonts.googleapis.com/css2?family=Crete+Round&family=Lato:wght@300;400;700&display=swap');
  
  @media only screen and (max-width: 768px) {
  .workout-card {
      flex-direction: column;
      width: 30% !important;
      align-items: flex-start;
      justify-content: flex-start;
  }

  .workout-history {
      flex-direction: row;
  }

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
  
  .workout-card {
      display: flex;
      width: 25%;
      min-width: 210px;
      max-width: 300px;
      flex-direction: column;
      align-items: center;
      margin: 0 20px 35px;
      padding: 15px 10px 20px;
      border: 5px solid #4C241D;
      border-radius: 12px;
      background-color: #ffce56;
      text-align: center;
  }

  .workout-card p {
      text-align: center;
      margin-bottom: 10px !important;
      margin-top: 0 !important;
  }

  .workout-card li {
      margin-bottom: 5px !important;
  }

  .workout-label {
      margin-bottom: 5px !important;
      margin-top: 5px !important;
  }
 
  .workout-list {
    padding: 10px 0;
    border-top: 4px solid  #4C241D;
    border-bottom: 4px solid #4C241D;
  }
  
  ul {
    text-align: left;
    margin-left: -30px;
    margin-bottom: 0 !important;
    margin-top: 5px !important;
  }
 
  .workout-label {
      margin-top: 5px !important;
  }

  .details {
      display: flex;
      flex-direction: column;
      width: 80%;
      align-items: center;
  }

  .btn-select {
      margin-top: 10px !important;
      padding-top: 8px !important;
      width: 100% !important;
      height: auto !important;
  }

  #dynamic-timestamp {
      margin-bottom: 20px !important;
  }
  
  </style>