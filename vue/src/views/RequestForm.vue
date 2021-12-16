
<template>
<section class="main">
      <div class="request-form">
            <h1 class="h3 headline mb-3 font-weight-normal">Request a New Exercise</h1>
            <h3 class="subhead">Complete the form below to request an exercise for addition to the library.</h3>

        <div class="form-fields">
            <div id="envelopes">
                <img id="envelopePic" src="../assets/new-request.png">
            </div>
            <form action="/action_page.php" id="request-fields">
               <div id="field-container">
                <div id="trainer-name" class="form-field">
                <label for="trainer">Trainer:</label>
                <select name="trainer" id="trainer">
                    <option value="1">Benny</option>
                    <option value="2">Juni</option>
                    <option value="3">Richard</option>
                    <option value="4">Connie</option>
                    <option value="5">Simon</option>
                </select>
                </div>

                <div id="trainer-input" class="form-field">
                <label for="exercise-name">Name of Exercise:</label>
                <input type="text" id="exercise-name" name="exercise-name" value="Name of Exercise">
                </div>

                <div id="desc-input" class="form-field">
                <label for="desc">Description:</label>
                <input type="text" id="desc" name="desc" value="Description">
                </div>

                <div id="target-input" class="form-field">
                <label for="target">Target:</label>
                <select name="target" id="target">
                    <option value="arms">Arms</option>
                    <option value="back">Back</option>
                    <option value="abs">Abs</option>
                    <option value="legs">Legs</option>
                    <option value="whole-body">Whole Body</option>
                    <option value="cardio">Cardio</option>
                </select>
                </div>

                <div id="weight-input" class="form-field">
                <label for="weight">Weight:</label>
                <input type="number" id="weight" min="1" max="100"/>
                </div>

                <div id="reps-input" class="form-field">
                <label for="reps">Reps:</label>
                <input type="number" id="reps" min="1" max="30"/>
                </div>

                <div id="duration-input" class="form-field">
                <label for="duration">Duration (minutes):</label>
                <input type="number" id="duration" min="1" max="20"/>
                </div>

                <div id="submit-input" class="form-field">
                <input type="submit" class="btn" value="Submit Request">
                </div>
               </div>
                 <p>Your request will be reviewed by the trainer for approval within 3-5 days.</p> 
              </form> 
           
        </div>
      </div>
   
   </section>
</template>

<script>
export default {
      name: 'request-form'
};
</script>

<style>
* {
  box-sizing: border-box;
}


@media only screen and (max-width: 768px) {
    
#envelopePic {
    width: 80% !important;
    height: auto;
    align-self: center;
    justify-content: center;
}

.form-fields {
padding: 25px;
padding-top: 0 !important;
flex-direction: column;
justify-items: center;
}

#envelopes {
    width: 100%;
}
} 



.request-form {
    display: flex;
    flex-direction: column;
    justify-content: center;
}

/* 
input, select {
    border: 1px solid #4C241D;
    border-radius: 4px;
    font-family: 'Lato', sans-serif;
    font-size: 15px;
    text-align: left;
    padding-left: 10px;
} */

.form-fields {
    padding: 25px;
    width: 100%;
    display: flex;
    justify-content: center;
}

.form-field {
  padding: 15px;
}

#envelopes {
    width: 200px;
    display: flex;
    align-self: center;
}

.smallPic {
    width: 100%;
}

.request-form label {
    padding-right: 15px;
}

@import url('https://fonts.googleapis.com/css2?family=Crete+Round&family=Lato:wght@300;400;700&display=swap');


</style>

