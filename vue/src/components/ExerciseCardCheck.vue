<template>
    <div class="exercise-card">
    <div>
        <img class="cardPic" v-bind:src="require('../assets/target-'+exercise.bodyTargetId.toLowerCase().replace(/\s+/g, '-')+'.png')"/> 
    </div>
    <div class="description">
    <div class="headline-text">
    <h2 id="dynamic-exercise">{{exercise.name}}</h2>  <div class="reg-text">{{exercise.suggestedWeight}} lbs. | {{exercise.reps}} reps | {{exercise.time}} min.</div>
    </div>
    <p>{{exercise.description}}</p>
    </div>
    <div>
        <img class="checkbox" :src="imgSrc" @click="unchecked = !unchecked" />
    </div>
</div>
</template>

<script>  
export default {
  props: {exercise:Object},
  name: 'exercise-card-check',
  

data() {
  return {
    unchecked: true
  }
},
computed: {
  imgSrc: function () {
    return this.unchecked ? require('../assets/incomplete.png') : require('../assets/complete.png')
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

    .cardPic {
        width: 50px;
        height: auto;
        padding-top: 15px !important;
    }

    .reg-text {
        text-align: center;
        padding-bottom: 30px;
    }

    .headline-text {
        flex-direction: column;
        gap: 0 !important;
        justify-items: center;
        text-align: center;
    }
}

.reg-text {
    font-size: 18px;
    font-family: 'Crete Round', serif;
    color: #4C241D;
    margin-bottom: -10px;
}

.headline-text {
     display: flex;
     align-items: center;
     gap: 20px;
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

.cardPic {
    width: 150px;
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