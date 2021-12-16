

<template>
<div class="exercise-list-card clickMe">
            <div class="details">

                <div class="cardPic">
                  <img class="dynamic-pic" v-bind:src="require('../assets/target-'+exercise.exerciseTarget.toLowerCase().replace(/\s+/g, '-')+'.png')"/>
                </div>

                <h2 class="dynamic-name">{{exercise.exerciseName}}</h2>
                <p class="dynamic-desc">{{exercise.exerciseDescription}}</p>

                <div class="exercise-details">

                  <div class="detail-name">
                    <h3>Weight: </h3>
                    <p class="dynamic-weight">{{exercise.weight}} lbs.</p>
                  </div>

                  <div class="detail-name">
                    <h3>Reps: </h3>
                    <p class="dynamic-reps">{{exercise.reps}}</p>
                  </div>

                  <div class="detail-name">
                    <h3>Duration: </h3>
                    <p class="dynamic-duration">{{exercise.exerciseDuration}} min.</p>
                  </div>
                </div>

            </div>
         </div>
</template>
<script>

export default {
    props: {exercise:Object},
}
</script>
<style scoped>

</style>