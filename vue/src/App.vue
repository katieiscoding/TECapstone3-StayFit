<template>
  <div id="app">
    <div id="nav">
      <div class="logotype">
      <router-link id="logotype" v-bind:to="{ name: 'customize' }"><img id="logo" alt="logo" src="./assets/list-of-workouts.png">
         <h1 id="appName">StayFit</h1>
      </router-link></div>
      <div id="nav-links">
      <div id="custom"><router-link v-bind:to="{ name: 'customize' }" v-if="$store.state.token != ''">Custom Workout</router-link></div>
      <div id="see-list"><router-link v-bind:to="{ name: 'exercise-list' }" v-if="$store.state.token != ''"> Areas of Focus</router-link></div>
      <!-- <div id="history"><router-link v-bind:to="{ name: 'workout-history' }" v-if="$store.state.token != ''">Workout History</router-link></div> -->
      <div id="logout"><router-link v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Sign Out</router-link></div>

      </div>
    </div>
    <router-view />
  </div>
</template>



<style>

@media only screen and (max-width: 768px) {

#app {
  align-content: center;
}  

#register {
  display: flex;
  width: 100%;
  flex-direction: column;
  padding-top: 10px !important;
}

#createAccount {
  text-align: center;
  font-size: 2em;
  margin-bottom: 5px;
  margin-top: 0px;
}

#password {
  margin-bottom: 10px;
}

.textLink {
  text-decoration: underline;
  font-size: 13px;
  font-family: 'Lato', 'sans-serif';
  color: #4C241D;
}

.login-register {
  display: flex;
  flex-direction: column;
}

.btn {
  width: 100%;
  margin-bottom: 20px;
}

.main {
  justify-content: center;
  width: 100%;
}

  #sidePic {
    width: 40% !important;
    padding-top: 10px;
    margin: 0 !important;
  }

  .bigPic {
    align-content: center;
    padding: 0 !important;
    margin-bottom: -10px !important;
  }

  a {
    text-decoration: none;
    font-size: 13px;
    font-family: 'Lato', 'sans-serif';
    color: #4C241D;
    }

    #nav {
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    #nav-links {
      padding: 20px !important;
      justify-content: center;
}
}




/* Below are all the universal styles for all components. These apply to both desktop and mobile. */

#appName {
  margin-top: 4px;
}

#nav-links {
  display: flex;
  padding: 10px !important;
  justify-content: center;
  gap: 25px;
}

#nav-links a {
  font-size: 17px !important;
  font-weight: 600;
}

.headline {
  text-align: center;
  font-size: 2em;
  margin-bottom: 0;
  margin-top: 0;
}

.main {
display: flex;
flex-flow: column nowrap;
align-items: center;
justify-content: center;
width: 100vw;
}

.loginBG {
 height: 430px;
}

.bigPic {
  display: flex;
  justify-content: center;
  width: 50%;
  height: auto;
  padding-right: 25px;
  margin-bottom: -80px;
}

#nav {
  background-color: #e1f4f4;
  border-bottom: 5px solid #4c241d;
  align-content: center;
  display: flex;
  flex-direction: column;
  padding-bottom: 5px;
  width: 100vw;
}

#sidePic {
  width: 100%;
  height: auto;
}

#app {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
  min-width: 100vh;
  background-color: #FFE4B8;
}

html, body {
  margin: 0;
  padding: 0;
  }

form {
  display: flex;
  flex-direction: column;
  align-items: center;
}

h1, h2, h3, h4, h5, h6 {
  font-family: 'Crete Round', serif;
  color: #4C241D;
} 

h1 {
    padding-bottom: 10px;
    padding-top: 5px !important;
    margin-bottom: 0;
}

.subhead {
  font-weight: 400;
  margin-top: 0;
  padding: 0 25px 0 25px;
  text-align: center;
}

p, label, input, .textLink {
  font-family: 'Lato', sans-serif;
  color: #4C241D;
  text-align: center;
}

input {
  padding: 5px;
}

label {
  margin-bottom: 8px;
}

a {
  text-decoration: none;
  font-size: 13px;
  font-family: 'Lato', 'sans-serif';
  color: #4C241D;
  text-align: right;
  }

#logotype {
  display: flex;
  margin: 20px;
  margin-bottom: 0;
}

#logo {
  width: 70px;
  height: auto;
  margin-top: -9px;
}

#appDesc {
  font-weight: 400;
  margin-top: 0;
  margin-bottom: 20px;
}

#register {
  display: flex;
  align-items: center;
  justify-content: center;
  padding-top: 25px;
}

#signIn {
  margin-top: 0;
}

.logotype {
  display: flex;
  align-self: center;
}

.alert-danger {
  font-family: 'Lato', sans-serif;
  color: #C22D00;
  font-weight: 600; 
  padding-bottom: 10px;
}

.alert-success {
  font-family: 'Lato', sans-serif;
  color: #536600;
  font-weight: 600; 
  padding-bottom: 10px;
}

.loginBG {
  display: flex;
  flex-direction: column;
  align-items: center;
  background-color: #ffce56;
  padding: 30px 40px;
  border: 5px solid #4c241D;
  border-radius: 12px;
}

.form-register {
  display: flex;
}

.textLink {
  text-decoration: underline;
  font-size: 14px;
  text-align: center;
}

.mt-2 {
  text-align: center;
}

.login-register {
  display: flex;
  flex-direction: column;
  flex-basis: 100%;
  width: 100%;
}

.login-field {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 0 10px 15px 10px;
}

.btn {
  background-color: #f96e43;
  padding: 12px 18px;
  margin: 0 10px 20px 10px;
  border: 2px solid #4c241D;
  border-radius: 4px;
  font-family: 'Lato', sans-serif;
  font-weight: 700;
  width: 230px;
  height: 50px;
  font-size: 1rem;
  text-align: center;
}

</style>